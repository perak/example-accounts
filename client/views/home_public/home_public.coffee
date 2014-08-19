Template.HomePublic.rendered = ->

Template.HomePublic.events "click #page-close-button": (e, t) ->
  Router.go "", {}
  return

Template.HomePublic.helpers {}
Template.HomePublicHomeJumbotron.rendered = ->

Template.HomePublicHomeJumbotron.events "click #jumbotron-button": (e, t) ->
  Router.go "login", {}
  return

Template.HomePublicHomeJumbotron.helpers {}
