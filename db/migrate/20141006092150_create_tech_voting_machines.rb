class CreateTechVotingMachines < ActiveRecord::Migration
  def change
    create_table :tech_voting_machines do |t|
      t.string :voting_equip_type
      t.date :purchase_dt
      t.string :equip_make
      t.integer :purchase_price
      t.integer :quantity
      t.string :offset_funds_src
      t.integer :offset_amount
      t.timestamps
    end
  end
end
