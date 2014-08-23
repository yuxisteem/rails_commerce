# Upload button for images form
$ ->
  $('#fileupload').fileupload
    dataType: 'html',
    start: ->
      $('#upload-progress').show()
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('#upload-progress-bar').css('width', progress + '%')
    done: (e, data) ->
      $('#admin-images-list').append(data.result)
      $('#upload-progress').hide()