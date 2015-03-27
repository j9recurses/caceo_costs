class AddDataTypeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :data_type, :string
  end
end
