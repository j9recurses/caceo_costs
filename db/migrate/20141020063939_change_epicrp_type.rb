class ChangeEpicrpType < ActiveRecord::Migration
  def change

    change_table :election_profiles do |t|
         t.change  :epicrp , :decimal, { :precision => 10, :scale => 2}
    end



  end
end
