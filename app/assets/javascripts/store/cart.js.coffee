cart =
  initialize: ->
    @cartModal = $ '#cart-modal'
    @cartContent = $ '#cart-modal-content'
    @cartItemsCount = $ '#cart-items-count'

  hide: ->
    @cartModal.modal 'hide'

  show: ->
    @cartModal.modal 'show'

  update: (html, count) ->
    @cartContent.html html
    @cartItemsCount.html count

  updateAndShow: (html, count) ->
    @update html, count
    @show()

$ ->
  cart.initialize()

window.Cart = cart