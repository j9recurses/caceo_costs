class AddTimestampsToSsbc < ActiveRecord::Migration
  def change
    add_column :ssbcs, :created_at, :datetime
    add_column :ssbcs, :updated_at, :datetime
  end
end
