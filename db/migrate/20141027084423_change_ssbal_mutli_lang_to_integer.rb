class ChangeSsbalMutliLangToInteger < ActiveRecord::Migration
  def change
    remove_column :ssbals, :ssbalpriobml
    remove_column :ssbals, :ssbalprisbml
    add_column :ssbals, :ssbalpriobml, :integer
    add_column :ssbals, :ssbalprisbml, :integer
  end
end
