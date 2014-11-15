module Admin::OrderEventsHelper
  BADGES = {
    'Order' => 'glyphicon-inbox',
    'Invoice' => 'glyphicon-usd',
    'Shipment' => 'glyphicon-plane',
    'Note' => 'glyphicon-comment'
  }

  def order_event_badge_for(event)
    glyphicon BADGES[event.event_type]
  end
end
