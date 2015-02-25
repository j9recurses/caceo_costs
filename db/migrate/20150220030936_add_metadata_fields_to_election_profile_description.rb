class AddMetadataFieldsToElectionProfileDescription < ActiveRecord::Migration
  def change
    change_table :election_profile_descriptions  do |t|
      t.string :survey_category
      t.string :question_type
      t.string :subsection
      t.references :validation_types
      t.references :surveys
    end
  end
end
