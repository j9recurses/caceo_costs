class Announcement < ActiveRecord::Base
  default_scope { order( created_at: :desc ) }

  def viewed_by?(user)
    if !user.announcements_viewed_at
      false
    else
      self.created_at <= user.announcements_viewed_at
    end
  end

  def self.count_new_for(user)
    if user.announcements_viewed_at
      Announcement.where("created_at > ?", user.announcements_viewed_at).count
    else
      Announcement.count
    end
  end
end
