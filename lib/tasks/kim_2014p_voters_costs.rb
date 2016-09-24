# 'eptotindirc', 'eptotelectc'
# [536, 537]

# Report for
require 'csv'

s_ids = SurveyResponse.where(
  election_id: 19,
  response_type: 'ElectionProfile'
  ).pluck(:id)

CSV.open(Rails.root + '2014g_Nov_Costs.csv', 'wb+') do |csv|
  csv << ['County', 'Registered Voters', 'Total Indirect Cost', 'Total Election Costs']
  s_ids.each do |s_id|

    rvs = ResponseValue.where(
      survey_response_id: s_id, 
      question_id: [483, 536, 537]
    )

    county = SurveyResponse.find(s_id).county.name

    csv << [
      county,
      rvs.where(question_id: 483).first.value,
      rvs.where(question_id: 536).first.value,
      rvs.where(question_id: 537).first.value,
    ]
  end
end