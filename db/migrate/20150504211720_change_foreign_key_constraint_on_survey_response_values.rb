class ChangeForeignKeyConstraintOnSurveyResponseValues < ActiveRecord::Migration
  def change
    remove_foreign_key :survey_response_values, :survey_responses
    rename_table :survey_response_values, :response_values
    add_foreign_key :response_values, :survey_responses, dependent: :destroy
  end
end
