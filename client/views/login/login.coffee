pageSession = new ReactiveDict()
pageSession.set "errorMessage", ""
Template.Login.rendered = ->

Template.Login.created = ->
  pageSession.set "errorMessage", ""
  return

Template.Login.events "submit #login_form": (e, t) ->
  e.preventDefault()
  submit_button = $(t.find(":submit"))
  login_email = t.find("#login_email").value.trim()
  login_password = t.find("#login_password").value
  
  # check email
  unless isValidEmail(login_email)
    pageSession.set "errorMessage", "Please enter your e-mail address."
    t.find("#login_email").focus()
    return false
  
  # check password
  if login_password is ""
    pageSession.set "errorMessage", "Please enter your password."
    t.find("#login_email").focus()
    return false
  Meteor.loginWithPassword login_email, login_password, (err) ->
    if err
      pageSession.set "errorMessage", err.message
      false
    else
      pageSession.set "errorMessage", ""
    return

  false

Template.Login.helpers errorMessage: ->
  pageSession.get "errorMessage"

