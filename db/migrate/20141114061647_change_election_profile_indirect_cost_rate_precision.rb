class ChangeElectionProfileIndirectCostRatePrecision < ActiveRecord::Migration
  def change
    change_column :election_profiles, :epicrp, :decimal, {:precision => 4, :scale => 2}
  end
end
