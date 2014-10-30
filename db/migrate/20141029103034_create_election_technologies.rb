class CreateElectionTechnologies < ActiveRecord::Migration
  def change
    create_table :election_technologies do |t|

      t.timestamps
    end
  end
end
