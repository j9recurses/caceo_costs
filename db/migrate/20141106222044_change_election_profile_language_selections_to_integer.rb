class ChangeElectionProfileLanguageSelectionsToInteger < ActiveRecord::Migration
  def change
    change_column :election_profiles, :eplangcaec, :integer
    change_column :election_profiles, :eplangvra, :integer
    change_column :election_profiles, :eplangloc, :integer
  end
end
