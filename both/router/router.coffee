Router.configure
  templateNameConverter: "upperCamelCase"
  routeControllerNameConverter: "upperCamelCase"
  layoutTemplate: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"

Router.ensureLogged = ->
  @redirect "home_public"  unless Meteor.user()
  return

Router.ensureNotLogged = ->
  @redirect "home_private"  if Meteor.user()
  return

if Meteor.isClient
  publicRoutes = [
    "home_public"
    "login"
    "register"
    "forgot_password"
    "reset_password"
  ]
  privateRoutes = [
    "home_private"
    "customers"
    "logout"
  ]
  Router.onBeforeAction Router.ensureNotLogged,
    only: publicRoutes

  Router.onBeforeAction Router.ensureLogged,
    only: privateRoutes

Router.map ->
  @route "home_public",
    path: "/"
    controller: "HomePublicController"

  @route "login",
    path: "/login"
    controller: "LoginController"

  @route "register",
    path: "/register"
    controller: "RegisterController"

  @route "forgot_password",
    path: "/forgot_password"
    controller: "ForgotPasswordController"

  @route "reset_password",
    path: "/reset_password"
    controller: "ResetPasswordController"

  @route "home_private",
    path: "/home_private"
    controller: "HomePrivateController"

  @route "customers",
    path: "/customers"
    controller: "CustomersController"

  @route "logout", #ROUTER_MAP
    path: "/logout"
    controller: "LogoutController"

  return

