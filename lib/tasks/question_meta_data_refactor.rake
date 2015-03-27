namespace :caceo do
  ###### SURVEYS
  desc "generate Surveys"
  task g_surveys: [:make_surveys, :format_surveys, :make_subsections] do
  end

  desc "fill ouy Survey table"
  task make_surveys: :environment do
    Question.group(:name).each do |s|
      type = s.table_name.singularize.camelize
      category = s.cost_type == "salaries" ? "Salaries" : "Services and Supplies"

      Survey.create!(title: s.name, response_type: type, table_name: s.table_name, category: category)
    end
    Survey.create!( title: "Election Profile", 
      response_type: "ElectionProfile", 
      table_name: "election_profiles", 
      category: "Election Profile")
  end

  desc "format survey titles and add subject"
  task format_surveys: :environment do
    Survey.all.each do |survey|
      survey.title = format_survey_label( survey.title )
      survey.subject = format_category( survey.title )
      survey.save!
    end
  end

  desc "create and populate subsections"
  task make_subsections: :environment do
    Subsection.first_or_create(title: 'Salaries - Tasks',                   totalable: true)
    Subsection.first_or_create(title: 'Salaries - Types of Staff and Pay',  totalable: true)
    Subsection.first_or_create(title: 'Benefits - in Dollars',              totalable: true)
    Subsection.first_or_create(title: 'Benefits - in Percent',              totalable: false)
    Subsection.first_or_create(title: 'Hours Worked',                       totalable: true)

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
  end

  ###### QUESTIONS
  desc "generate Questions"
  task make_questions: [:make_ep_questions, :update_questions]

  desc "fill election profile na and question_type"
  task make_ep_questions: :environment do
    ElectionProfileDescription.all.each do |q|
      Question.create!(
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
    Question.where("field LIKE '%ssbalpri%b%ml'").update_all(question_type: 'multi_select')
    Question.where.not(table_name: "election_profiles").each do |q|
      klass = q.table_name.camelize.singularize.constantize

      sum_able = klass.column_types[q.field].type == :integer && q.question_type != 'multi_select'
      if q.question_type == 'comment'
        na_able = false
      else
        na_able = true
      end

      q.label = format_survey_label( q.label )
      q.survey = Survey.find_by(table_name: q.table_name)
      q.sum_able = sum_able
      q.na_able = na_able
      q.data_type = klass.column_types[q.field].type.to_s
      q.na_field = na_able ? "#{q.field}_na" : nil
      q.save!
    end
  end


  desc "fill out survey_responses"
  task fill_survey_responses: :environment do
    GeneralSurvey::DIRECT_COST_SURVEYS.each do |name|
      klass.all.each do |r|
        survey_response = SurveyResponse.find_by(response: r)
        if survey_response
          survey_response.update(county: r.county)
        else
          # SurveyResponse.find_or_create_by(response: )
          # r.find_or_create
        end
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