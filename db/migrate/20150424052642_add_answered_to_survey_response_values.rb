class AddAnsweredToSurveyResponseValues < ActiveRecord::Migration
  def change
    add_column :survey_response_values, :answered, :boolean, null: false, default: false
  end
end
