Uploadify::Rails.configure do |config|
  config.uploader        = '/admin/images'
  config.buttonText      = lambda { I18n.t('uploader.upload_file') }
  config.queueID         = 'file_upload_queue'
  config.onUploadSuccess = true
end