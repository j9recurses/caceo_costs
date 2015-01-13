class DropAnnouncementState < ActiveRecord::Migration
  def change
    drop_table :announcement_states
  end
end
