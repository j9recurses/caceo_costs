class RemoveAnsweredFromResponseValueAddNaConstraints < ActiveRecord::Migration
  def change
    remove_column :response_values, :answered
    change_column :response_values, :na_value, :boolean, null: false, default: false
    remove_foreign_key :response_values, :survey_responses
    add_foreign_key :response_values, :survey_responses, on_delete: :cascade
  end
end
