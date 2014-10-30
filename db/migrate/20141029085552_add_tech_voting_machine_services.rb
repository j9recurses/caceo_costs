class AddTechVotingMachineServices < ActiveRecord::Migration
  def change
      create_table :tech_voting_softwares do |t|
      t.string :software_type
      t.date :purchase_dt
      t.integer :purchase_price_hardware
       t.integer :purchase_price_software
      t.integer :mat_charges
      t.integer :labor_costs
      t.integer :county
      t.timestamps
   end
       add_column :tech_voting_machines , :purchase_price_services, :boolean
     end
end
