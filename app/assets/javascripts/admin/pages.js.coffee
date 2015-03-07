$('.edit-page').ready ->
  titleInputSel = '#page_title'
  $(titleInputSel).on 'input', ->
    $('#page_seo_url').attr('value', formatLink($(titleInputSel).val()))


formatLink = (text) ->
  text.replace(/\W/g,'_').toLowerCase()