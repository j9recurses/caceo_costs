class ChangeModelNameToSurveyModelName < ActiveRecord::Migration
  def change
    rename_column :categories, :model_name, :table_name
    rename_column :category_descriptions, :model_name, :table_name
    rename_column :election_profile_descriptions, :model_name, :table_name
  end
end
