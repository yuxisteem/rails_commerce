module Admin::XEditableHelper
  def x_editable_for(model, path, type: 'text', field: nil)
    model_name = ActiveModel::Naming.singular(model)
    link_to model.send(field), '#', data: { name: model_name, type: type, path: path, xeditable: true }
  end
end
