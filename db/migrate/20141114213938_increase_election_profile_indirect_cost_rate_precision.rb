class IncreaseElectionProfileIndirectCostRatePrecision < ActiveRecord::Migration
  def change
    change_column :election_profiles, :epicrp, :decimal, {:precision => 6, :scale => 2}
  end
end
