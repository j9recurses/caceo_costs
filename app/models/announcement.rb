class Announcement < ActiveRecord::Base
  has_many :announcement_states, inverse_of: :announcement
  has_many :users, through: :announcement_states
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
