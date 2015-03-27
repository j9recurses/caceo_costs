class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name, null: false
      t.integer :question_id, null: false
    end
  end
end
