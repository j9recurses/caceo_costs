class AddDateDescripToElectionProfileYears < ActiveRecord::Migration
  def change
    add_column :election_year_profiles, :edate_full, :string
    add_column :election_years, :edate_full, :string
  end
end
