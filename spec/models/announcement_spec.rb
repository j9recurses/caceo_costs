require 'rails_helper'

RSpec.describe Announcement, :type => :model do
  let(:new_user)     { FactoryGirl.create(:user) }
  let(:announcement) { FactoryGirl.create(:announcement) }

  before(:all) { @announcement_count = Announcement.count }

  describe 'with new user' do
    it 'announcement not viewed' do
      expect( announcement.viewed_by?(new_user) ).to be(false)
    end

    it 'counts 1 unviewed announcement' do
      announcement
      expect( Announcement.count_new_for(new_user) ).to be(@announcement_count + 1)
    end
  end

  describe 'after touching viewed' do
    it 'is viewed' do
      announcement
      new_user.touch(:announcements_viewed_at)
      expect( announcement.viewed_by?(new_user) ).to be(true)
    end

    it 'counts 0 unviewed announcements' do
      expect( Announcement.count_new_for(new_user) ).to be(@announcement_count + 0)
    end
  end
end