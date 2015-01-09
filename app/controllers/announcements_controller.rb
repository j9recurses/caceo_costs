class AnnouncementsController < ApplicationController
  def index
    @last_viewed = current_user.announcements_viewed_at
    current_user.touch(:announcements_viewed_at)
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      redirect_to action: :index
    else
      flash.now[:error] = 'Could not save announcement'
      render :new
    end
  end

  def destroy
    Announcement.destroy(params[:id])
    redirect_to announcements_url
  end

  private

  def announcement_params
    params.require(:announcement).permit(:message, :id)
  end
end
