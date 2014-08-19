@HomePrivateController = RouteController.extend(
  template: "HomePrivate"
  yieldTemplates: {}
  
  #YIELD_TEMPLATES
  onBeforeAction: ->

  
  #BEFORE_FUNCTION
  action: ->
    @render()
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
      title: "Welcome {{userFullName}}!"
      meta:
        description: "Meteor Kitchen - example application"

      og:
        title: "Welcome {{userFullName}}!"
        description: "Meteor Kitchen - example application"

    return
)
