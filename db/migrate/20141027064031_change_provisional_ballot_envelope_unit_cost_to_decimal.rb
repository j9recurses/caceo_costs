class ChangeProvisionalBallotEnvelopeUnitCostToDecimal < ActiveRecord::Migration
  def change
    change_column :ssbals, :ssbalpriprou, :decimal, precision: 3, scale: 2
  end
end
