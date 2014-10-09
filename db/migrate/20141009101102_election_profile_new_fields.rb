class ElectionProfileNewFields < ActiveRecord::Migration

#add and remove columns to the election profile table
def change
add_column :election_profiles, :epppbalpapar, :boolean
add_column :election_profiles, :epppbalpapbu, :boolean
add_column :election_profiles, :epppbalpapot, :boolean
add_column :election_profiles, :epvbmretpp, :integer
add_column :election_profiles, :epvbmirevl, :integer
add_column :election_profiles, :epvbmrrevl, :integer
add_column :election_profiles, :epprovcwbt, :integer
add_column :election_profiles, :epprovcwp, :integer
add_column :election_profiles, :epprovncvnr, :integer
add_column :election_profiles, :epprovncbrva, :integer
add_column :election_profiles, :epprovncoth, :integer
add_column :election_profiles, :epprovvbm, :integer
add_column :election_profiles, :epprovnor, :integer
add_column :election_profiles, :epprovhava, :integer
add_column :election_profiles, :epprovunivs, :integer
add_column :election_profiles, :epprovoutr, :integer
add_column :election_profiles, :epcanvdrere, :integer
add_column :election_profiles, :eplangvra, :string
add_column :election_profiles, :eplangcaec, :string
add_column :election_profiles, :eplangloc, :string
add_column :election_profiles, :eptotcandca, :integer
add_column :election_profiles, :eptotvolunth, :integer
remove_column :election_profiles, :eplangnoeng, :integer
  end
end
