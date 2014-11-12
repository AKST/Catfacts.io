Session.set-default \counter, 0

Template.hello.helpers do
  counter: ->
    Session.get \counter

Template.hello.events do
  'click button': ->
    Session.set \counter, 1 + Session.get \counter

