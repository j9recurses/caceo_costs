class AddElectionYearToElectionProfile < ActiveRecord::Migration
  def change
    add_reference :election_profiles, :election_year, index: true, foreign_key: true
  end
end
