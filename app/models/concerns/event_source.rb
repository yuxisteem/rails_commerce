module EventSource
  extend ActiveSupport::Concern

  included do
    after_update :log_event, if: :aasm_state_changed?
  end


  def update(params, updated_by: nil)
    @updated_by_user = updated_by
    super params
  end

  def log_event
    obj_id = try(:order_id) || id
    OrderEvent.log_transition(obj_id, self.class.name,
                                aasm_state_change[0], aasm_state_change[1], @updated_by_user)
  end
end
