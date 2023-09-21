module TwilioService
 ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
 AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
 PHONE_NUMBER = ENV['TWILIO_PHONE_NUMBER']

 def self.send_sms(to:, text:)
   client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

   client.messages.create(
     from: PHONE_NUMBER,
     to: to,
     body: text,
   )
 rescue Twilio::REST::RestError => e
   Rails.logger.error "Twilio Error: #{e.message}"
   nil
 end
end
