class AddCodeToElectionYear < ActiveRecord::Migration
  def change
    add_column :election_years, :code, :string
  end
end
