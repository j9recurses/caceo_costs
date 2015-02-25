class RenameCategoryDescriptionToQuestion < ActiveRecord::Migration
  def change
    rename_table :category_descriptions, :questions
  end
end
