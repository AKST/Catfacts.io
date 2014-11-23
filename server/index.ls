
twilio-client = new Twilio(
  Config.twilio.account_sid
  Config.twilio.auth_token
)


Meteor.methods do
  text-message: WhenValid.phone-number (phone-number) ->
    twilio-error, res <-! twilio-client.send-sms do
      body: Random.random-item cat-facts
      from: Config.twilio.number
      to: phone-number

    if twilio-error?
      console.error twilio-error
    else
      console.log 'message sent'


