class RemoveElectionYearIndexFromElectionProfile < ActiveRecord::Migration
  def change
    remove_index :election_profiles, column: :current_step
    remove_index :election_profiles, column: :election_year_id
    remove_column :election_profiles, :started
    remove_column :election_profiles, :complete
    remove_column :election_profiles, :current_step
  end
end