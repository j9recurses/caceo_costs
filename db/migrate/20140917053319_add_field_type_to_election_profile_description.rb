class AddFieldTypeToElectionProfileDescription < ActiveRecord::Migration
  def change
    add_column :election_profile_descriptions, :fieldtype, :string
  end
end
