class ChangeEpLangLocToString < ActiveRecord::Migration
  def change
    change_column :election_profiles, :eplangloc, :text
  end
end
