class ChangeProvisionalBallotEnvelopeUnitCostToDecimalMore < ActiveRecord::Migration
  def change
    remove_column :ssbals, :ssbalpriprou
    add_column :ssbals, :ssbalpriprou, :decimal, {:precision => 3, :scale => 2}
end
end
