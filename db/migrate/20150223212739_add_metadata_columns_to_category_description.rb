class AddMetadataColumnsToCategoryDescription < ActiveRecord::Migration
  def change
    add_column :category_descriptions, :validation_type_id, :integer
    add_column :category_descriptions, :subsection_id, :integer, index: true
    add_column :category_descriptions, :survey_id, :integer, null: false, index: true

    add_column :category_descriptions, :sum_able, :boolean, null: false, default: false
    add_column :category_descriptions, :na_able, :boolean, null: false, default: false

    add_foreign_key :category_descriptions, :validation_types
    add_foreign_key :category_descriptions, :subsections
    add_foreign_key :category_descriptions, :surveys
  end
end
