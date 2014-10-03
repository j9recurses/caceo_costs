class ChangeElectionYearType < ActiveRecord::Migration
  def change
    change_column :election_years, :year, :string
  end
end
