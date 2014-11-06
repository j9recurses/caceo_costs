class ChangeSsbalMultiLangToIntegerForBugMerge < ActiveRecord::Migration
  def change
    change_column :ssbals, :ssbalpriobml, :integer
    change_column :ssbals, :ssbalprisbml, :integer
  end
end
