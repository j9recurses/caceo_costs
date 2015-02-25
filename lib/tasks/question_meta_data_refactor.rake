namespace :caceo do
  desc "rewrite election profile metadata"
  task :ep_description => [:environment] do
    election_profile = ElectionProfile.new
    question_relation = ElectionProfileDescription.all

    question_relation.each do |row|

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

  desc "fill election profile na and question_type"
  task :ep_question_metadata do
    ElectionProfileDescription.all.each do |q|
      Question.create!(
          label: q.label,
          description: q.description,
          field: q.field,
          table_name: q.table_name,
          sum_able: false,
          na_able: true,
          survey: Survey.find_by(title: "Election Profile"),
          question_type: ( q.field.match(/eplang(vra|caec)/) ? "multi_select" : nil )
        )
    end
  end

  desc "format survey titles and add subject"
  task format_surveys: :environment do
    Survey.all.each do |survey|
      survey.title = format_survey_label( survey.title )
      survey.subject = format_category( survey.title )
      survey.save!
    end
  end

  desc "create survey subsections and hook them up"
  task create_subsections: :environment do
    # Subsection.create!(title: 'Salaries', totalable: true)
    # Subsection.create!(title: 'Election Profile', totalable: false)
    # Subsection.create!(title: 'Services and Supplies', totalable: true)

  end

  def determine_question_type(catq)

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
        .gsub("And", "and")
        .gsub("For", "for")
        .gsub("To", "to")
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