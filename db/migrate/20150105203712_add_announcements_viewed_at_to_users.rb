class AddAnnouncementsViewedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :announcements_viewed_at, :datetime
  end
end
