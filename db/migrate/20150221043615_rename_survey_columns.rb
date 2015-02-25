class RenameSurveyColumns < ActiveRecord::Migration
  def change
    rename_column :surveys, :survey_type, :type
    rename_column :surveys, :survey_category, :category
  end
end