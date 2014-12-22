class RemoveCommentNaFromSalbal < ActiveRecord::Migration
  def change
    remove_column :salbals, :salbalcomment_na, :boolean
  end
end
