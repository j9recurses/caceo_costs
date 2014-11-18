class AddCountyIdToAccessCode < ActiveRecord::Migration
  def change
    add_column :access_codes, :county_id, :integer
  end
end
