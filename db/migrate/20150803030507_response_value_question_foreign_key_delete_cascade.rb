class ResponseValueQuestionForeignKeyDeleteCascade < ActiveRecord::Migration
  def change
    remove_foreign_key :response_values, :questions
    add_foreign_key :response_values, :questions, on_delete: :cascade
  end
end
