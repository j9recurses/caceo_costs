class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      SupportMailer.contact_us(@message).deliver
      redirect_to home_path, :notice => "Thanks! Your message was sent."
      return
    else
      render :new
    end
  end
end
