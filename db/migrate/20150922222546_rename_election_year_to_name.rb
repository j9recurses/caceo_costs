class RenameElectionYearToName < ActiveRecord::Migration
  def change
    rename_column :elections, :year, :name
  end
end
