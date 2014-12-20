class AddNaColumnsToSalbal < ActiveRecord::Migration
  def change
    change_table(:salbals) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salbaldesign_na, :salbaltrans_na, :salbalorder_na, :salbalmail_na, 
        :salbalother_na, :salbalpsrp_na, :salbalpsop_na, :salbaltsrp_na, :salbaltsop_na,
        :salbalbeps_na, :salbalbepsp_na, :salbalbets_na, :salbalbetsp_na, :salbalhrsps_na,
        :salbalhrsts_na, default: false, null: false
    end
  end
end
