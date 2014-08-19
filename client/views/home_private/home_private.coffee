Template.HomePrivate.rendered = ->

Template.HomePrivate.events "click #page-close-button": (e, t) ->
  Router.go "", {}
  return

Template.HomePrivate.helpers {}
