class CreateSurveySubsection < ActiveRecord::Migration
  def change
    create_table :survey_subsections do |t|
      t.references :survey, index: true
      t.references :subsection, index: true
    end
    add_foreign_key :survey_subsections, :surveys
    add_foreign_key :survey_subsections, :subsections
  end
end
