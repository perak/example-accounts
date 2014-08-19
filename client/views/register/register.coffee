pageSession = new ReactiveDict()
pageSession.set "errorMessage", ""
Template.Register.rendered = ->

Template.Register.created = ->
  pageSession.set "errorMessage", ""
  return

Template.Register.events "submit #register_form": (e, t) ->
  e.preventDefault()
  submit_button = $(t.find(":submit"))
  register_name = t.find("#register_name").value.trim()
  register_email = t.find("#register_email").value.trim()
  register_password = t.find("#register_password").value
  
  # check name
  if register_name is ""
    pageSession.set "errorMessage", "Please enter your name."
    t.find("#register_name").focus()
    return false
  
  # check email
  unless isValidEmail(register_email)
    pageSession.set "errorMessage", "Please enter valid e-mail address."
    t.find("#register_email").focus()
    return false
  
  # check password
  min_password_len = 6
  unless isValidPassword(register_password, min_password_len)
    pageSession.set "errorMessage", "Your password must be at least " + min_password_len + " characters long."
    t.find("#register_password").focus()
    return false
  Accounts.createUser
    email: register_email
    password: register_password
    profile:
      name: register_name
  , (err) ->
    if err
      pageSession.set "errorMessage", err.message
    else
      pageSession.set "errorMessage", ""
    return

  false

Template.Register.helpers errorMessage: ->
  pageSession.get "errorMessage"

