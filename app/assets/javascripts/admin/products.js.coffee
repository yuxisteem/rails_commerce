# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  inventoryCheckbox = $('#product_track_inventory')
  inventoryFields = $('#inventory-fields')

  inventoryCheckbox.change ->
    if (@checked)
      inventoryFields.fadeIn()
    else
      inventoryFields.fadeOut()

  inventoryFields.hide() unless inventoryCheckbox[0].checked
