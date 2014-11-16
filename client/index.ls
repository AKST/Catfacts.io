Router.configure do
  layoutTemplate: \main


Router.route '/', ->
  @render \signup, do
    to: \body


Template.signup.created = ->
  @submitable = new ReactiveVar false


Template.signup.helpers do
  disabled: -> 
    not Template.instance!.submitable.get!


Template.signup.events do
  'keydown input, keyup input': (e, self) ->
    self.submitable.set validate-phone-number e.target.value
    # when enter key is hit submit form
    if self.submitable.get! and e.key-code is 13
      self.$('form').submit()

  'submit': (e, self) ->
    self.submitable.set false
    field = self.$ 'input[name=phone-number]'
    if validate-phone-number field.val!
      # checked incase it didn't disable properly
      field.val '' 
    return false


validate-phone-number = (number) ->
  return false unless number[0] is '+'
  return false unless number.length > 8
  return false unless _.all (number.split ''), (e) -> e in '0123456789+ '
  return true


