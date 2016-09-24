require 'csv'

srs = SurveyResponse.where(county_id: 28)
srs.each do |sr|
  survey_name = Survey.find(sr.response_type).title
  CSV.open(Rails.root + "napa/2014g_Napa_#{sr.response_type}.csv", 'wb+') do |csv|
    csv << ['2014 General Election', survey_name]
    csv << ['Survey Item', 'Response', 'Description']

    values = sr.values
    values.each do |v|
      q = Question.find(v.question_id)
      csv << [q.label, v.value, q.description]
    end
  end
end