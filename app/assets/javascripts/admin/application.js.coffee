#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require jquery.turbolinks
#= require jquery-ui
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

Turbolinks.enableProgressBar()
