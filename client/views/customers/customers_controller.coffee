@CustomersController = RouteController.extend(
  template: "Customers"
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
      title: "Customers"
      meta:
        description: "Meteor Kitchen - example application"

      og:
        title: "Customers"
        description: "Meteor Kitchen - example application"

    return
)
