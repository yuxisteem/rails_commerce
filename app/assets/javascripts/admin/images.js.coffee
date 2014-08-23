# Upload button for images form
$ ->
  uploadProgress = $('#upload-progress')
  uploadProgressBar = $('#upload-progress-bar')
  imagesList = $('#admin-images-list')
  $('#fileupload').fileupload
    dataType: 'html',
    start: ->
      uploadProgress.show()
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      uploadProgressBar.css('width', progress + '%')
    done: (e, data) ->
      imagesList.append(data.result)
      uploadProgressBar.css('width', '0%')
      uploadProgress.hide()