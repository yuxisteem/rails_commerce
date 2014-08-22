module Admin::ImagesHelper
  def image_upload_tag(imageable_type, imageable_id, id: 'fileupload', url: '')
    form_data = {imageable_type: imageable_type, imageable_id: imageable_id}.to_json
    %(
      <input id="#{id}", type="file", name="files[]", data-form-data='#{form_data}', data-url="#{url}">
     ).html_safe
  end
end
