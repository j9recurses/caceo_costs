class SyncLocalToRemoteSchema < ActiveRecord::Migration
  def change
    # remove_index :categories, :election_year_id
    # remove_index :users, :county_id
    # rename_index :survey_responses, 'index_survey_responses_on_election_id', 'fk_rails_d8b174e70a'
  end
end
