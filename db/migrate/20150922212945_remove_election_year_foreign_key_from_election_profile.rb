class RemoveElectionYearForeignKeyFromElectionProfile < ActiveRecord::Migration
  def change
    remove_foreign_key :election_profiles, :election_years
  end
end
