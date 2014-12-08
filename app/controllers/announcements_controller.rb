class AnnouncementsController < ApplicationController
  def index
    @announcement = Announcement.last
  end
end
