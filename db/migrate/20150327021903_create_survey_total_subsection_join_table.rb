class CreateSurveyTotalSubsectionJoinTable < ActiveRecord::Migration
  def change
    create_join_table :surveys, :subsections, table_name: 'survey_totals_subsections' do |t|
      t.index [:survey_id, :subsection_id]
    end
  end
end
