namespace :caceo do

  desc "generate all new metadata structure and content"
  task g_meta: [:g_surveys, :g_questions, :g_subsections, :g_survey_responses]

  desc "generate Surveys"
  task g_surveys: [:make_surveys, :format_surveys]

  desc "generate SurveyResponess and ResponseValues"
  task g_survey_responses: [:make_survey_responses, :make_response_values]

  ###### SURVEYS
  desc "fill out Survey table"
  task make_surveys: :environment do
    Question.group(:name).each do |s|
      type = s.table_name.singularize.camelize
      category = s.cost_type == "salaries" ? "Salaries" : "Services and Supplies"
      unless Survey.where(id: type).count > 0
        Survey.find_or_create_by!(title: s.name, id: type, table_name: s.table_name, category: category)
      end
    end

    Survey.find_or_create_by!( title: "Election Profile", 
      id: "ElectionProfile", 
      table_name: "election_profiles", 
      category: "Election Profile"
    ) unless Survey.where(id: 'ElectionProfile').count > 0
  end

  desc "format survey titles and add subject"
  task format_surveys: :environment do
    Survey.all.each do |survey|
      survey.title = format_survey_label( survey.title )
      survey.subject = format_category( survey.title )
      survey.save!
    end
  end

  ###### SUBSECTIONS
  desc "create and populate subsections"
  task g_subsections: :environment do
    Subsection.find_or_create_by!(title: 'Salaries - Tasks',                   totalable: true)
    Subsection.find_or_create_by!(title: 'Salaries - Types of Staff and Pay',  totalable: true)
    Subsection.find_or_create_by!(title: 'Benefits - in Dollars',              totalable: true)
    Subsection.find_or_create_by!(title: 'Benefits - in Percent',              totalable: false)
    Subsection.find_or_create_by!(title: 'Hours Worked',                       totalable: true)

    Question.where("label LIKE '%Salaries%'")
      .update_all(subsection_id: Subsection.find_by(title: 'Salaries - Types of Staff and Pay').id )
    Question.where("label LIKE '%Benefits%percent%'")
      .update_all(subsection_id: Subsection.find_by(title: 'Benefits - in Percent').id )
    Question.where("label LIKE '%Benefits%dollars%'")
      .update_all(subsection_id: Subsection.find_by(title: 'Benefits - in Dollars').id )
    Question.where("label LIKE '%Hours%'").where.not(table_name: 'election_profiles')
      .update_all(subsection_id: Subsection.find_by(title: 'Hours Worked').id )

    Question.where(cost_type: "salaries", subsection: nil)
      .update_all(subsection_id: Subsection.find_by(title: 'Salaries - Tasks').id )

    salary_totals = Subsection.where("title = 'Salaries - Types of Staff and Pay' OR title = 'Benefits - in Dollars'")
    Survey.where(category: "Salaries").each {|s| s.update_attributes(totals_subsections: salary_totals)}

    salary_subsections = Subsection.where.not("title LIKE '%percent%'")
    Survey.where(category: "Salaries").each {|s| s.subsections << salary_subsections}
    Survey.find_by(table_name: 'salbals').subsections << Subsection.where("title LIKE '%percent%'")
  end

  ###### QUESTIONS
  desc "generate Questions"
  task g_questions: [:make_ep_questions, :update_questions]

  desc "fill election profile na and question_type"
  task make_ep_questions: :environment do
    ElectionProfileDescription.all.each do |q|
      Question.find_or_create_by!(
          label: format_survey_label( q.label ),
          description: q.description,
          field: q.field,
          table_name: q.table_name,
          sum_able: false,
          na_able: true,
          survey: Survey.find_by(title: "Election Profile"),
          question_type: ( q.field.match(/eplang(vra|caec)/) ? "multi_select" : nil ),
          data_type: ElectionProfile.column_types[q.field].type.to_s,
          na_field: "#{ q.field }_na"
        )
    end
  end

  desc "Clean and update Questions, connect to other models"
  task update_questions: :environment do
    # benefits percent, non-salbal questions
    Question.destroy_all(field: ["salbcbepsp", "salbcbetsp", "salcanbepsp", 
      "salcanbetsp", "saldojobepsp", "saldojobetsp", "salmedbepsp", 
      "salmedbetsp", "salothbepsp", "salothbetsp", "salppbepsp", 
      "salppbetsp", "salpwbepsp", "salpwbetsp", "salvbmbepsp", 
      "salvbmbetsp"])

    Question.where("field LIKE 'ssbalpri%b%ml'").update_all(question_type: 'multi_select')
    # were wrongly marked as comments, and in practice not na_able
    Question.where("field LIKE 'ssbalpri%b%mc'").update_all(question_type: nil, na_able: true)
    Question.where.not(table_name: "election_profiles").each do |q|
      klass = q.table_name.camelize.singularize.constantize

      data_type = klass.column_types[q.field].type.to_s
      sum_able = data_type == 'integer' && q.question_type != 'multi_select'
      if q.question_type == 'comment'
        na_able = false
      else
        na_able = true
      end

      q.label     = format_survey_label( q.label )
      q.survey    = Survey.find_by(table_name: q.table_name)
      q.sum_able  = sum_able
      q.na_able   = na_able
      q.data_type = data_type
      q.na_field  = na_able ? "#{q.field}_na" : nil
      q.save!
    end
  end

  # desc "Create Options on multi_select Questions"
  # task g_options: :environment do
  #   Ssbal::LANGUAGES.each do |lang|
  #     Option.find_or_create_by!(name: lang)
  #   end

    
  #   ssbal_langs = Option.where(name: Ssbal::LANGUAGES)

  #   Question.where('field LIKE "ssbalpri%ml"').each do |q|
  #     q.options <<  ssbal_langs
  #   end
  # end

  #### SURVEY RESPONSES
  desc "generate survey_responses for each response for election profiles and direct cost surveys"
  task make_survey_responses: :environment do
    GeneralSurvey::DIRECT_COST_SURVEYS.each do |klass|
      klass.all.each do |r|
        sr = SurveyResponse.find_or_create_by!(
          county_id: r.county_id,
          response: r,
          election_id: r.election_year_id
        )
        sr.created_at = r.created_at
        sr.updated_at = r.updated_at
        sr.save!
      end
    end

    ElectionProfile.all.each do |ep|
      sr = SurveyResponse.find_or_create_by!(
        county_id: ep.county_id,
        response: ep,
        election: ElectionYear.find_by( year: ElectionYearProfile.find( ep.election_year_profile_id ).year ),
      )
      sr.created_at = ep.created_at
      sr.updated_at = ep.updated_at
      sr.save!
    end
  end

  desc "generate response_values for each survey_response"
  task make_response_values: :environment do
    SurveyResponse.transaction do
      SurveyResponse.all.each do |sr|
        ResponseValue.sync_survey_response(sr)
      end
    end
  end

  def format_survey_label(text)
    if text.nil?
      return text
    else
      text.titleize
        .gsub("Uocava","UOCAVA")
        .gsub("Vbm","VBM")
        .gsub('Doj', "DOJ")
        .gsub("Dre","DRE")
        .gsub("Sb90","SB90")
        .gsub("Vb Ms", "VBMs")
        .gsub("Icrp", "ICRP")
        .gsub("Vra", "VRA")
        .gsub("Dr Es", "DREs")
        .gsub("Hava", "HAVA")
        .gsub("Ca Ec", "CA EC")
        .gsub(/(?!^)(\bBy\b|\bThe\b|\bAt\b|\bAnd\b|\bFor\b|\bTo\b|\bIn\b|\bOf\b|\bOr\b|\bOn\b)(?!$)/) {|m| $1.downcase}
        .gsub(/\bId\b/, "ID")
    end
  end

  def format_category(text)
    format_survey_label(text)
      .gsub('Vbm', "VBM")
      .gsub('Doj', "DOJ")
      .gsub("Salaries Related to ", '')
      .gsub("Salaries for ", "")
      .gsub(" Services and Supplies", '')
  end
end