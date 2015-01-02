class Announcement < ActiveRecord::Base
  has_many :announcement_states, inverse_of :announcement
  has_many :users, through: :announcement_states
end
