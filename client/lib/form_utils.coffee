@isValidEmail = (value) ->
  filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
  return true  if filter.test(value)
  false

@isValidPassword = (value, min_length) ->
  return false  if not value or value is "" or value.length < min_length
  true

@validateForm = (formObject, validationCallback, errorCallback, submitCallback) ->
  values = {}
  error = false
  formObject.find("input,select,textarea").each ->
    
    # auto set data type for checkbox
    
    # single checkbox with that name means dataType="BOOL" else it is "ARRAY"
    validationError = (errorMessage) ->
      inputObject.parent().addClass "has-error"
      inputObject.focus()
      errorLabel.text errorMessage  if errorLabel
      errorCallback errorMessage  if errorCallback
      error = true
      return
    inputObject = $(this)
    fieldName = inputObject.attr("name")
    labelObject = inputObject.parent().find("label[for='" + fieldName + "']")
    errorLabel = inputObject.parent().find("#error-text")
    fieldValue = inputObject.val()
    dataType = (if inputObject.attr("data-type") then inputObject.attr("data-type").toUpperCase() else "STRING")
    if inputObject.attr("type") is "checkbox"
      unless inputObject.attr("data-type")
        if formObject.find("input[name='" + fieldName + "']").length is 1
          dataType = "BOOL"
        else
          dataType = "ARRAY"
      fieldValue = inputObject.is(":checked")  if dataType is "BOOL"
      fieldValue = (if inputObject.is(":checked") then fieldValue else "")  if dataType is "ARRAY"
    minValue = inputObject.attr("data-min")
    maxValue = inputObject.attr("data-max")
    labelText = (if inputObject.attr("placeholder") then inputObject.attr("placeholder") else "")
    labelText = (if labelObject then labelObject.text() else fieldName)  unless labelText
    
    # Check required
    if inputObject.attr("required") and not fieldValue
      validationError labelText + " is required"
      return false
    
    # Convert to bool
    fieldValue = (if fieldValue then true else false)  if dataType is "BOOL"
    
    # Check Integer, also min and max value
    if dataType is "INTEGER"
      intValue = parseInt(fieldValue)
      if isNaN(intValue)
        validationError labelText + ": Invalid value entered"
        return false
      if minValue and not isNaN(parseInt(minValue)) and intValue < parseInt(minValue)
        validationError labelText + " must be equal or greater than " + minValue
        return false
      if maxValue and not isNaN(parseInt(maxValue)) and intValue > parseInt(maxValue)
        validationError labelText + " must be equal or less than " + maxValue
        return false
      fieldValue = intValue
    
    # Check Float, also Min and Max value
    if dataType is "FLOAT"
      floatValue = parseFloat(fieldValue)
      if isNaN(floatValue)
        validationError labelText + ": Invalid value entered"
        return false
      if minValue and not isNaN(parseFloat(minValue)) and floatValue < parseFloat(minValue)
        validationError labelText + " must be equal or greater than " + minValue
        return false
      if maxValue and not isNaN(parseFloat(maxValue)) and floatValue > parseFloat(maxValue)
        validationError labelText + " must be equal or less than " + maxValue
        return false
      fieldValue = floatValue
    
    # Check valid E-mail address
    if dataType is "EMAIL"
      filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
      unless filter.test(fieldValue)
        validationError labelText + ": please enter valid e-mail address"
        return false
    if dataType is "ARRAY"
      newValue = (if values[fieldName] then values[fieldName] else [])
      newValue.push fieldValue  if fieldValue
      fieldValue = newValue
    
    # Custom validation
    if validationCallback
      errorMessage = validationCallback(fieldName, fieldValue)
      if errorMessage
        validationError errorMessage
        return false
    values[fieldName] = fieldValue
    return

  return  if error
  submitCallback values  if submitCallback
  return

@bootboxDialog = (template, data, options) ->
  div = document.createElement("div")
  UI.insert UI.renderWithData(template, data), div
  options.message = div
  bootbox.dialog options
  return
