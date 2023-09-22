class MessagesController < ApplicationController
 before_action :authenticate_user!

def create
 @message = current_user.messages.build(message_params)

 if @message.save
   TwilioService.send_sms(recipient_phone: @message.recipient_phone, text: @message.text)
   redirect_to messages_path, notice: 'Message sent!'
 else
   flash.now[:alert] = @message.errors.full_messages.join(', ')
   render :new
 end
end

 def index
  @messages = current_user.messages.order(created_at: :desc)
  respond_to do |format|
    format.html
    format.json { render json: @messages }
  end
 end

 def new
  @message = Message.new
 end

 def count
  count = current_user.messages.count
  render json: { message_count: count }
 end

 private

 def message_params
  params.require(:message).permit(:recipient_phone, :text)
 end
end
