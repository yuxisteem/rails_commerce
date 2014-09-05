$ ->
  sortableRoot = $ '#sortable'

  sortableRoot.sortable
    update: ->
      updateOrder($('.ui-sortable-handle'), sortableRoot.data('sort-url'))

  sortableRoot.disableSelection()

  updateOrder = (items, url) ->
    newOrder = (items.map -> $(this).data('id')).toArray()

    $.ajax
      type: 'POST'
      url: url
      data:
        'ids[]': newOrder
