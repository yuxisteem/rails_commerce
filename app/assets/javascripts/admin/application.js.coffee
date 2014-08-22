#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require jquery-ui
#= require jquery-fileupload/jquery.fileupload
#= require jquery-fileupload/jquery.iframe-transport
#= require_tree .

$("#menu-toggle").click (e) ->
  e.preventDefault()
  $("#wrapper").toggleClass "active"
  return
