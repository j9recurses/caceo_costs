class RenameCaCountyInfoToCounty < ActiveRecord::Migration
  def change
    rename_table :ca_county_infos, :counties
  end
end
