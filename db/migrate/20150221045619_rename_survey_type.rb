class RenameSurveyType < ActiveRecord::Migration
  def change
    rename_column :surveys, :type, :response_type
  end
end
