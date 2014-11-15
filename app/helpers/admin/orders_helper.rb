module Admin::OrdersHelper
  def select_for_states(name, model, disabled: false)
    states = model.aasm.states.map { |s| [s.display_name, s.name] }
    select_tag name, options_for_select(states, model.aasm.current_state), disabled: disabled
  end
end
