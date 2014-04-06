# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  mapCanvas = $('#map-delivery')
  if mapCanvas.length
    initialize = ->
    latlng = new google.maps.LatLng(-34.397, 150.644)
    myOptions =
      zoom: 8

    map = new google.maps.Map(mapCanvas[0], myOptions)
    
    google.maps.event.addDomListener window, "load", initialize
    codeAddress(mapCanvas.data('address'), map)
    return

codeAddress = (address, map) ->
  geocoder = new google.maps.Geocoder()
  geocoder.geocode address: address, (results, status) ->
      location = results[0].geometry.location
      if location
        map.setCenter(location)
        marker = new google.maps.Marker(
          map: map
          position: location
        )