class AddCommentNaToSalbal < ActiveRecord::Migration
  def change
    add_column :salbals, :salbalcomment_na, :boolean
  end
end
