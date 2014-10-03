class ChangeFieldTypesForElectionProfiles < ActiveRecord::Migration
  def change
    change_column :election_profiles, :epicrp, :decimal
    change_column :election_profiles, :epbalpage, :string
  end
end
