class AddUniquenessConstraintToSurveyResponses < ActiveRecord::Migration
  def change
    add_index :survey_responses, [:county_id, :election_id, :response_type], 
      {unique: true, name: 'index_survey_responses_on_county_election_and_survey'}
  end
end
