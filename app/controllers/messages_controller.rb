class MessagesController < ApplicationController
 before_action :authenticate_user!

 def create
   @message = current_user.messages.build(message_params)

   if @message.text.present? && valid_phone_number?(@message.recipient_phone)
     if @message.save
       TwilioService.send_sms(recipient_phone: @message.recipient_phone, text: @message.text)
       redirect_to(messages_path)
     else
       raise RuntimeError, 'Error while saving the message'
     end
   else
     raise RuntimeError, 'Invalid number or Text is blank'
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

 def valid_phone_number?(phone_number)
   /^\d{10}$/ === phone_number
 end
end
