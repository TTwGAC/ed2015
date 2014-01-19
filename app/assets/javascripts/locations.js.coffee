# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

hide_button_groups = ->
  for button in $("#location_selector button")
    $(button).removeClass 'active'
    $("##{$(button).val()}_group").hide()

$(document).ready ->
  hide_button_groups()

  for button in $("#location_selector button")
    $(button).bind 'click', (event) ->
      hide_button_groups()
      $(this).addClass 'active'
      $("##{$(this).val()}_group").show()
  $('#location_selector button').first().trigger('click')
