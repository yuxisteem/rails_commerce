module Admin::XEditableHelper
  def x_editable_for(model, url, type: 'text', field: nil)
    model_name = ActiveModel::Naming.singular(model)
    link_to model.send(field) || '', '#', data: { name: model_name, type: type, url: url, field: field, xeditable: true }
  end
end
