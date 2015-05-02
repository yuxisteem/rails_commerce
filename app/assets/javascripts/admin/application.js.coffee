#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require jquery.turbolinks
#= require jquery-ui
#= require bootstrap-switch
#= require bootstrap-sprockets
#= require jquery.fileupload
#= require bootstrap-editable
#= require bloodhound.js
#= require typeahead.jquery
#= require_tree .

$("#menu-toggle").click (e) ->
  e.preventDefault()
  $("#wrapper").toggleClass "active"
  return

# Enable bootstrap tooltips on all pages
$ ->
  $("[data-toggle='tooltip']").tooltip()
  return

$ ->
  bootstrapSwitch = $('[data-remote-checkbox]').bootstrapSwitch()

  bootstrapSwitch.bootstrapSwitch()

  bootstrapSwitch.on 'switchChange.bootstrapSwitch', (evt, state) ->
    value = state ? 1 : 0
    param = $(@).attr('name')
    model_name = $(@).data('model')

    data = {}
    data[model_name] = {}
    data[model_name][param] = value

    $.ajax
      method: 'PATCH'
      url: $(@).data('url')
      data: data
      dataType: 'json'


Turbolinks.enableProgressBar()
