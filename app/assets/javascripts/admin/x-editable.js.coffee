$ ->
  $('[data-xeditable]').editable
    ajaxOptions:
      type: 'PATCH'

    send: 'always'

    params: (params) ->

      el = $(@)
      model_name = el.data('name')
      field_name = el.data('field')

      params_ext = {}
      params_ext[model_name] = {}

      params_ext[model_name][field_name] = params.value
      console.log params_ext
      params_ext
