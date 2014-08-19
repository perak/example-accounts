pageSession = new ReactiveDict()
pageSession.set "errorMessage", ""
Template.ResetPassword.rendered = ->


# change password
Template.ResetPassword.events "submit #reset_password_form": (e, t) ->
  e.preventDefault()
  submit_button = $(t.find(":submit"))
  new_password = t.find("#new_password").value
  new_password_confirm = t.find("#new_password_confirm").value
  
  # check password
  min_password_len = 6
  unless isValidPassword(new_password, min_password_len)
    pageSession.set "errorMessage", "Your password must be at least " + min_password_len + " characters long."
    t.find("#new_password").focus()
    return false
  unless new_password is new_password_confirm
    pageSession.set "errorMessage", "Your password and confirm password doesn't match."
    t.find("#new_password_confirm").focus()
    return false
  Accounts.resetPassword @resetPasswordToken, new_password, (err) ->
    if err
      pageSession.set "errorMessage", err.message
    else
      pageSession.set "errorMessage", ""
    return

  false

Template.ResetPassword.helpers errorMessage: ->
  pageSession.get "errorMessage"

