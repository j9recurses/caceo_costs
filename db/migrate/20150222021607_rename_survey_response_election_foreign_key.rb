class RenameSurveyResponseElectionForeignKey < ActiveRecord::Migration
  def change
    rename_column :survey_responses, :election_year_id, :election_id
  end
end
