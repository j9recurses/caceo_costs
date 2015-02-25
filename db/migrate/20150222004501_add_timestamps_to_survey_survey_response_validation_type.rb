class AddTimestampsToSurveySurveyResponseValidationType < ActiveRecord::Migration
  def change
    add_column :validation_types, :updated_at, :datetime 
    add_column :validation_types, :created_at, :datetime

    add_column :surveys, :updated_at, :datetime 
    add_column :surveys, :created_at, :datetime 
    
    add_column :survey_responses, :updated_at, :datetime 
    add_column :survey_responses, :created_at, :datetime 
  end
end
