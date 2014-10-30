class Changesoftwarefield < ActiveRecord::Migration
  def change
    rename_column :tech_voting_softwares, :software_type, :software_item
  end
end
