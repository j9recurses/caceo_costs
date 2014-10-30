class ChangeProvisionalBallotEnvelopeUnitCostToDecimal < ActiveRecord::Migration
  def change
    change_column :ssbals, :ssbalpriprou, :decimal
  end
end
