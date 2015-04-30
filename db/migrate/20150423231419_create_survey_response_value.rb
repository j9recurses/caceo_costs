class CreateSurveyResponseValue < ActiveRecord::Migration
  def change
    create_table :survey_response_values do |t|
      t.references  :survey_response, index: true, foreign_key: true
      t.references  :question, index: true, foreign_key: true
      t.string      :data_type
      t.integer     :integer_value
      t.decimal     :decimal_value
      t.string      :string_value
      t.text        :text_value
      t.boolean     :na_value
      t.timestamps null: false
    end
  end
end
