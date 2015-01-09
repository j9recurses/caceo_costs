require 'rails_helper'

RSpec.describe Announcement, :type => :model do
  let(:new_user)     { FactoryGirl.create(:user) }
  let(:announcement) { FactoryGirl.create(:announcement) }

  describe 'with new user' do
    it 'announcement not viewed' do
      expect( announcement.viewed_by?(new_user) ).to be(false)
    end
  end

  describe 'after touching viewed' do
    it 'is viewed' do
      announcement
      new_user.touch(:announcements_viewed_at)
      expect( announcement.viewed_by?(new_user) ).to be(true)
    end
  end
end