
Router.route '/', ->
  @layout \center
  @render \signup,
    to: \body


Template.signup.created = ->
  @submitable = new ReactiveVar false
  @editable = new ReactiveVar true
  @show-warning = new ReactiveVar false
  @show-success = new ReactiveVar false


Template.signup.helpers do
  disable-submit: -> 
    not Template.instance!submitable.get!

  disable-input: ->
    not Template.instance!editable.get!

  show-warning: ->
    self = Template.instance!
    show = self.show-warning.get!
    if self.show-warning.get!
      <-! Events.wait 10000
      self.$ '.alert-warning' .remove-class 'in'
      <-! Events.wait 1000 
      self.show-warning.set false
    return show

  show-success: -> 
    self = Template.instance!
    show = self.show-success.get!
    if self.show-success.get!
      <-! Events.wait 2500 
      self.$ '.alert-success' .remove-class 'in'
      <-! Events.wait 1000
      self.show-success.set false
    return show


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
      self.editable.set false
      error, result <- Meteor.call 'textMessage', phone-number
      self.editable.set true
      unless error?
        field.val ''
        self.show-success.set true
      else
        self.show-warning.set true

    return false


