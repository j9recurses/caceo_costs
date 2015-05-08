class AddBooleanValueToSurveyResponseValue < ActiveRecord::Migration
  def change
    add_column :survey_response_values, :boolean_value, :boolean
  end
end
