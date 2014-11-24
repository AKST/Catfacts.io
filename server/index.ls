@Future = Future = undefined

Meteor.startup !->
  Future := Npm.require 'fibers/future'

twilio-client = new Twilio(
  Config.twilio.account_sid
  Config.twilio.auth_token
)

message-for = (phone-number) ->
  body: Random.random-item cat-facts
  from: '(906) 629-1051' 
  to: phone-number

Meteor.methods do
  text-message: WhenValid.phone-number (phone-number) ->
    future = new Future!

    twilio-client.send-sms (message-for phone-number), (twilio-error, res) !->
      if twilio-error?
        future.throw twilio-error
      else
        future.return "success" 

    return future.wait!

