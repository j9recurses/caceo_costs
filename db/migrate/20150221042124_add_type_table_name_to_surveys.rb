class AddTypeTableNameToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :survey_type, :string
    add_column :surveys, :survey_category, :string
    add_column :surveys, :table_name, :string
  end
end
