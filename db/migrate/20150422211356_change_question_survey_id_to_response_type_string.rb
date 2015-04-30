class ChangeQuestionSurveyIdToResponseTypeString < ActiveRecord::Migration
  def change
    # questions don't have response_type, need to empty column and re-fill
    remove_column :questions, :survey_id
    add_column :questions, :survey_id, :string, limit: 20
    
    # just putting limit on length
    change_column :survey_responses, :response_type, :string, limit: 20

    # remove constraints so changing survey id works
    remove_foreign_key "survey_subsections", "surveys"
    remove_index "survey_totals_subsections", name: "index_survey_totals_subsections_on_survey_id_and_subsection_id"

    # change column, primary key
    remove_column :surveys, :id
    rename_column :surveys, :response_type, :id
    change_column :surveys, :id, :string, limit: 20
    execute 'ALTER TABLE surveys ADD PRIMARY KEY(id);'

    remove_column :survey_subsections, :survey_id
    add_column :survey_subsections, :survey_id, :string, limit: 20

    remove_column :survey_totals_subsections, :survey_id
    add_column :survey_totals_subsections, :survey_id, :string, limit: 20
  end
end