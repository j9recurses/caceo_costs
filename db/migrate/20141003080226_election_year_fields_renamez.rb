class ElectionYearFieldsRenamez < ActiveRecord::Migration
  def change
    rename_column :election_years, :el_typ, :election_type
  end
end
