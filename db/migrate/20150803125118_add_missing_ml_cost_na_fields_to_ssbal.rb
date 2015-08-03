class AddMissingMlCostNaFieldsToSsbal < ActiveRecord::Migration
  def change
    add_column :ssbals, :ssbalprisb1mc_na, :boolean, null: false, default: false
    add_column :ssbals, :ssbalprisb2mc_na, :boolean, null: false, default: false
    add_column :ssbals, :ssbalprisb3mc_na, :boolean, null: false, default: false
    add_column :ssbals, :ssbalpriob1mc_na, :boolean, null: false, default: false
    add_column :ssbals, :ssbalpriob2mc_na, :boolean, null: false, default: false
    add_column :ssbals, :ssbalpriob3mc_na, :boolean, null: false, default: false
  end
end
