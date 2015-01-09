class Announcement < ActiveRecord::Base
  has_many :announcement_states, inverse_of: :announcement
  has_many :users, through: :announcement_states
  default_scope { order( created_at: :desc ) }

  def viewed_by?(user)
    !!(user.announcements_viewed_at && (self.created_at <= user.announcements_viewed_at))
  end
end
