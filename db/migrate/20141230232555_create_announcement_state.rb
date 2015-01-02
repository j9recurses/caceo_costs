class CreateAnnouncementState < ActiveRecord::Migration
  def change
    create_table :announcement_states do |t|
      t.boolean :dismissed
      t.references :announcement
      t.references :user
    end
  end
end
