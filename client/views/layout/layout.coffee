Template.layout.rendered = ->
  
  # scroll to anchor
  $("body").on "click", "a", (e) ->
    href = $(this).attr("href")
    if href.length > 1 and href.charAt(0) is "#"
      hash = href.substring(1)
      if hash
        e.preventDefault()
        offset = $("*[id=\"" + hash + "\"]").offset()
        if offset
          $("html,body").animate
            scrollTop: offset.top - 50
          , 400
    else
      $("html,body").scrollTop 0  if href.indexOf("http://") isnt 0 and href.indexOf("https://") isnt 0 and href.indexOf("#") isnt 0
    return

  return


#TEMPLATE_RENDERED_CODE
Template.PublicLayoutLeftMenu.rendered = ->

Template.PublicLayoutLeftMenu.events {}
Template.PublicLayoutLeftMenu.helpers {}
Template.PublicLayoutRightMenu.rendered = ->

Template.PublicLayoutRightMenu.events {}
Template.PublicLayoutRightMenu.helpers {}
Template.PrivateLayoutLeftMenu.rendered = ->

Template.PrivateLayoutLeftMenu.events {}
Template.PrivateLayoutLeftMenu.helpers {}
Template.PrivateLayoutRightMenu.rendered = ->

Template.PrivateLayoutRightMenu.events {}
Template.PrivateLayoutRightMenu.helpers {}
