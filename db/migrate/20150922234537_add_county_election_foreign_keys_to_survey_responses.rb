class AddCountyElectionForeignKeysToSurveyResponses < ActiveRecord::Migration
  def change
    add_foreign_key :survey_responses, :counties
    add_foreign_key :survey_responses, :elections
  end
end
