class AnnouncementState < ActiveRecord::Base
  belongs_to :announcement, inverse_of :announcement_states
  belongs_to :user, inverse_of :announcement_states
end
