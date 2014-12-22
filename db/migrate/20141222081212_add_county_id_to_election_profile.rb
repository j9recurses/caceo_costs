class AddCountyIdToElectionProfile < ActiveRecord::Migration
  def change
    rename_column :election_profiles, :county, :county_id
  end
end
