class AddMoreMlToSsbal < ActiveRecord::Migration
  def change
    remove_column :ssbals, :ssbalpriobml, :integer
    remove_column :ssbals, :ssbalprisbml, :integer

    add_column :ssbals, :ssbalprisb1ml, :integer
    add_column :ssbals, :ssbalprisb2ml, :integer
    add_column :ssbals, :ssbalprisb3ml, :integer
    add_column :ssbals, :ssbalprisb1mc, :integer
    add_column :ssbals, :ssbalprisb2mc, :integer
    add_column :ssbals, :ssbalprisb3mc, :integer

    add_column :ssbals, :ssbalpriob1ml, :integer
    add_column :ssbals, :ssbalpriob2ml, :integer
    add_column :ssbals, :ssbalpriob3ml, :integer
    add_column :ssbals, :ssbalpriob1mc, :integer
    add_column :ssbals, :ssbalpriob2mc, :integer
    add_column :ssbals, :ssbalpriob3mc, :integer
  end
end
