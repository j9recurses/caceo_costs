class RenameResponseToSurveyResponse < ActiveRecord::Migration
  def change
    rename_table :responses, :survey_responses
  end
end
