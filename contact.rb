# Required gems
require 'pry'
require 'rubygems'
require 'twilio-ruby'

def contact_by_sms(recipient)
  # TODO: Need to pass in selection from the previous methods
 
  # Need to add account_sid and auth_token for method to work
  account_sid = 'account_sid'
  auth_token = 'auth_token'
  client = Twilio::REST::Client.new account_sid, auth_token
  from = "+61451266980" # Your Twilio number
  
  # This loop is required for Twilio integration to function
  recipient.each do |key, value|
    client.messages.create(
      from: from,
      to: key,
      body: "Hi #{value}, could I please put some rubbish in your bin"
      )
    puts "Sent message to #{value}" # TODO: Need to pass in current user contact name
  end

end