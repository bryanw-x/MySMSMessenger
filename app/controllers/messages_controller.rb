class MessagesController < ApplicationController
 before_action :authenticate_user!

 def create
  @message = current_user.messages.build(message_params)

  if @message.save
   TwilioService.send_sms(to: @message, text: @message.text)
   redirect_to messages_path, notice: 'Message sent!'
  else
   render :new, alert: 'Message not sent!'
  end
 end

 def index
  @messages = current_user.messages.order(created_at: :desc)
 end

 def new
  @message = Message.new
 end
 private

 def message_params
  params.require(:message).permit(:to, :text)
 end
end
