# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.edit_product').ready ->
  attributesComplete = new AttributesAutocomplete()
  inventoryControl = new InventoryControl()






class AttributesAutocomplete
  constructor: ->
    @attributeFields = $(@attributeFieldsSelector)
    @attributeFields.each (index, element) =>
      $(element).typeahead
        hint: true,
        highlight: true,
        minLength: 1
      ,
        name: 'value',
        displayKey: 'value',
        source: @getSourceAdapter(element)

  getSourceAdapter: (element) ->
    source = new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: [$(element).data('path') + '?q=%QUERY'].join '/'

    source.initialize()
    source.ttAdapter()

  attributeFieldsSelector: '.typeahead'


class InventoryControl
  constructor: ->
    @inventoryCheckbox = $(@inventoryCheckbox)
    @inventoryFields = $(@inventoryFields)
    @initEvents()
  initEvents: ->
    @inventoryCheckbox.change =>
      if (@inventoryCheckbox.is(':checked'))
        @inventoryFields.fadeIn()
      else
        @inventoryFields.fadeOut()

    @inventoryFields.hide() if @inventoryCheckbox[0] && !@inventoryCheckbox[0].checked

  inventoryCheckbox: '#product_track_inventory'
  inventoryFields: '#inventory-fields'
