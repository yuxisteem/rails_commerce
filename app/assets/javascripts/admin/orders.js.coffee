# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  OrderPanel.init()
  DeliveryMap.init()


DeliveryMap =
  selector: '#map-delivery'
  init: ->
    @element = $('#map-delivery')[0]
    if @element
      initialize = ->
      latlng = new google.maps.LatLng(-34.397, 150.644)
      myOptions =
        zoom: 8

      map = new google.maps.Map(@element, myOptions)

      google.maps.event.addDomListener window, "load", initialize
      @codeAddress($(@element).data('address'), map)
      return
  codeAddress: (address, map) ->
    geocoder = new google.maps.Geocoder()
    geocoder.geocode address: address, (results, status) ->
        location = results[0].geometry.location
        if location
          map.setCenter(location)
          marker = new google.maps.Marker(
            map: map
            position: location
          )



OrderPanel =
  selector: '#order-panel'
  init: ->
    @element = $(@selector)
    form = @element.find('form.edit_order')
    form.find('select').each (idx, select) ->
      $(select).on 'change', (e) ->
        form.submit()

Admin.Views.OrderPanel = OrderPanel
