@LogoutController = RouteController.extend(
  template: "Logout"
  yieldTemplates: {}
  
  #YIELD_TEMPLATES
  onBeforeAction: ->

  
  #BEFORE_FUNCTION
  action: ->
    App.logout()
    return

  
  #ACTION_FUNCTION
  waitOn: ->
    []

  
  #WAIT_FUNCTION
  data: ->
    params: @params or {}

  
  #DATA_FUNCTION
  onAfterAction: ->
    SEO.set
      title: "Example application"
      meta:
        description: "Meteor Kitchen - example application"

      og:
        title: "Example application"
        description: "Meteor Kitchen - example application"

    return
)
