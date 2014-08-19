Template.Customers.rendered = ->

Template.Customers.events "click #page-close-button": (e, t) ->
  Router.go "", {}
  return

Template.Customers.helpers {}
