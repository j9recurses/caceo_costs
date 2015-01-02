class RenameUserCounty < ActiveRecord::Migration
  def change
    rename_column :users, :county, :county_id
  end
end
