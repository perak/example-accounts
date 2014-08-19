Router.onBeforeAction "loading"
@App = {}
@Helpers = {}
Meteor.startup ->

App.logout = ->
  Meteor.logout (err) ->

  return

Helpers.menuItemClass = (routeName) ->
  return ""  unless Router.current(true)
  return ""  unless Router.routes[routeName]
  currentPath = Router.current(true).path
  routePath = Router.routes[routeName].originalPath
  params = Router.current(true).params
  for key of params
    routePath = routePath.replace(":" + key, params[key])  unless key is "hash"
  return (if currentPath is routePath then "active" else "")  if routePath is "/"
  (if currentPath.indexOf(routePath) is 0 then "active" else "")

Helpers.userFullName = ->
  name = ""
  name = Meteor.user().profile.name  if Meteor.user()
  name

_.each Helpers, (helper, key) ->
  Handlebars.registerHelper key, helper
  return

