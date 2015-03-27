class AddNaFieldToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :na_field, :string
  end
end
