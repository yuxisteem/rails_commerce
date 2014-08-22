# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Upload button for product form
$ ->
  $('#fileupload').fileupload
    dataType: 'json',
    done: (e, data) ->
      for file in data.result.files
        $('<p/>').text(file.name).appendTo($('#images'))
