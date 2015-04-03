class RemoveSurveyIdFromSurveyResponses < ActiveRecord::Migration
  def change
    remove_column :survey_responses, :survey_id
  end
end
