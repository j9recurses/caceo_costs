class AddUniqIndexToSurveyResponseValues < ActiveRecord::Migration
  def change
    add_index :survey_response_values, [:survey_response_id, :question_id], unique: true, name: :index_on_survey_response_values_survey_response_questions
  end
end
