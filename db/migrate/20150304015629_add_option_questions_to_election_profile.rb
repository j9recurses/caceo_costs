class AddOptionQuestionsToElectionProfile < ActiveRecord::Migration
  def change
    add_column :election_profiles, :eplangvrao, :integer, array: true
    add_column :election_profiles, :eplangcaeco, :integer, array: true
  end
end
