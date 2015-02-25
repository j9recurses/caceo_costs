class RenameYearElementToResponse < ActiveRecord::Migration
  def change
    rename_table :year_elements, :responses
  end
end
