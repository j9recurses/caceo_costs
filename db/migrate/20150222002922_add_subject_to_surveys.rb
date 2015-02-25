class AddSubjectToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :subject, :string
  end
end
