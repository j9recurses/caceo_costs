class AddQuestionTypeToCategoryDescription < ActiveRecord::Migration
  def change
    add_column :category_descriptions, :question_type, :string
  end
end
