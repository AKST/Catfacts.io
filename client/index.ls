
Router.route '/', ->
  @layout \center
  @render \signup,
    to: \body


Template.signup.created = ->
  @submitable = new ReactiveVar false


Template.signup.helpers do
  disabled: -> 
    not Template.instance!submitable.get!


Template.signup.events do
  'keydown input, keyup input': (e, self) ->
    self.submitable.set IsValid.phone-number e.target.value
    # when enter key is hit submit form
    if self.submitable.get! and e.key-code is 13
      self.$('form').submit()

  'submit': (e, self) ->
    self.submitable.set false
    field = self.$ 'input[name=phone-number]'
    phone-number = field.val!
    # checked incase it didn't disable properly
    if IsValid.phone-number phone-number 
      field.val '' 
      Meteor.call 'textMessage', phone-number
    return false


