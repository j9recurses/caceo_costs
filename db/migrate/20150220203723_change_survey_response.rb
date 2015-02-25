class ChangeSurveyResponse < ActiveRecord::Migration
  def change
    rename_column :survey_responses, :element_id, :response_id
    rename_column :survey_responses, :element_type, :response_type
    add_column :survey_responses, :survey_id, :integer, null: false
    add_column :survey_responses, :county_id, :integer, null: false

    change_column :survey_responses, :response_type, :string, null: false
    change_column :survey_responses, :response_id, :integer, null: false
    change_column :survey_responses, :election_year_id, :integer, null: false
  end
end
