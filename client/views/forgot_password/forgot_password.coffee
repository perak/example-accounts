pageSession = new ReactiveDict()
pageSession.set "errorMessage", ""
pageSession.set "resetPasswordSent", ""
Template.ForgotPassword.rendered = ->

Template.ForgotPassword.events
  
  # send reset password link
  "submit #forgot_password_form": (e, t) ->
    e.preventDefault()
    submit_button = $(t.find(":submit"))
    reset_email = t.find("#reset_email").value.trim()
    
    # check email
    unless isValidEmail(reset_email)
      pageSession.set "errorMessage", "Please enter your e-mail address."
      t.find("#reset_email").focus()
      return false
    Accounts.forgotPassword
      email: reset_email
    , (err) ->
      if err
        pageSession.set "errorMessage", err.message
      else
        pageSession.set "errorMessage", ""
        pageSession.set "resetPasswordSent", true
      return

    false

  
  # button "OK" in information box after reset password email is sent
  "click #reset_password_sent": (e, t) ->
    pageSession.set "resetPasswordSent", false
    true

Template.ForgotPassword.helpers
  errorMessage: ->
    pageSession.get "errorMessage"

  resetPasswordSent: ->
    pageSession.get "resetPasswordSent"

