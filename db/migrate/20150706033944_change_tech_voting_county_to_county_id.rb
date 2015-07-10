class ChangeTechVotingCountyToCountyId < ActiveRecord::Migration
  def change
    rename_column :tech_voting_softwares, :county, :county_id
    rename_column :tech_voting_machines,  :county, :county_id
  end
end
