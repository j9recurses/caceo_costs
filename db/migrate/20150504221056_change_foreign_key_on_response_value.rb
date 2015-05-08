class ChangeForeignKeyOnResponseValue < ActiveRecord::Migration
  def change
    remove_foreign_key :response_values, :survey_responses
    add_foreign_key :response_values, :survey_responses, dependent: :delete
  end
end
