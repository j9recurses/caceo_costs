class ChangeElectionProfileFieldToInt < ActiveRecord::Migration
  def change
      change_column :election_profiles, :epicrp, :integer
  end
end
