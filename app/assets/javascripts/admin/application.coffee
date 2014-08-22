#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require_tree .

$("#menu-toggle").click (e) ->
  e.preventDefault()
  $("#wrapper").toggleClass "active"
  return
