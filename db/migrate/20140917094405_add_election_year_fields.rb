class AddElectionYearFields < ActiveRecord::Migration
  def change
    add_column :election_years  , :election_dt ,  :date
    add_column :election_years  , :year_dt,
    add_column :election_years  , :el_typ, :string
  end
end
