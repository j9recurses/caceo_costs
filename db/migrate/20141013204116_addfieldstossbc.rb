class Addfieldstossbc < ActiveRecord::Migration
  def change
    add_column :ssbcs, :election_year_id, :integer
    add_column :ssbcs, :county, :integer
    add_column :ssbcs, :current_step, :string
    add_index :ssbcs,  :current_step
  end
end

