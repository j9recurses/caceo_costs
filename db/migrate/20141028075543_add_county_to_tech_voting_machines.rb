class AddCountyToTechVotingMachines < ActiveRecord::Migration
  def change
       add_column :tech_voting_machines , :county, :integer
  end
end
