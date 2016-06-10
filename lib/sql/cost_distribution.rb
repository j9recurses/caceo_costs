q = <<-SQL
SELECT
  sr.response_type AS survey,
  q.field AS question,
  SUM(rv.integer_value) AS cost
FROM response_values AS rv
INNER JOIN survey_responses AS sr
  ON  sr.id = rv.survey_response_id
  AND sr.election_id = 19
INNER JOIN questions q
  ON  q.id = rv.question_id
  AND q.sum_able = 1
GROUP BY rv.question_id
ORDER BY cost DESC
SQL
r=ActiveRecord::Base.connection.exec_query q

require 'csv'
CSV.open('cost_by_question_2014g.csv', 'wb') do |csv|
  csv << ['survey', 'question', 'cost']
  r.each do |c|
    csv << [c['survey'], c['question'], c['cost']]
  end
end
