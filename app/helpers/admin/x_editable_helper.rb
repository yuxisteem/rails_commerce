module Admin::XEditableHelper
  def x_editable_for(model, path, type: 'text', field: nil)
    model_name = ActiveModel::Naming.singular(model)
    "<a data-field=#{field} data-name='#{model_name}' data-type='#{type}' data-url='#{path}' data-xeditable href='#'>#{h model.send(field)}</a>".html_safe
  end
end
