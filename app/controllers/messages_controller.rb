class MessagesController < ApplicationController
before_action :authenticate_user

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
      if @message.valid?
        NotificationsMailer.new_message(@message).deliver
        redirect_to home_path, :notice => "Thanks! Your message was sent."
        return
      else
        render :new
      end
  end

end
