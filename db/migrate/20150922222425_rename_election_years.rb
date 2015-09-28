class RenameElectionYears < ActiveRecord::Migration
  def change
    rename_table :election_years, :elections
  end
end
