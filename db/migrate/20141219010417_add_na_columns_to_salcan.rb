class AddNaColumnsToSalcan < ActiveRecord::Migration
  def change
    change_table(:salcans) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salcanprep_na, :salcanproc_na, :slacanoth_na, :salcanpsrp_na, 
        :salcanpsop_na, :salcantsrp_na, :salcantsop_na, :salcanbeps_na, 
        :salcanbepsp_na, :salcanbets_na, :salcanbetsp_na, :salcanhrsps_na, 
        :salcanhrsts_na, default: false, null: false
    end
  end
end