class RenameElectionProfileDescriptionColumns < ActiveRecord::Migration
  def change
    rename_column :election_profile_descriptions, :validation_types_id, :validation_type_id
    rename_column :election_profile_descriptions, :surveys_id, :survey_id
  end
end
