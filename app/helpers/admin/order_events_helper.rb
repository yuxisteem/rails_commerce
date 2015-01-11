module Admin::OrderEventsHelper
  EVENTS_BADGES = {
    'Order' => 'glyphicon-inbox',
    'Invoice' => 'glyphicon-usd',
    'Shipment' => 'glyphicon-plane',
    'Note' => 'glyphicon-comment',
    'Email' => 'glyphicon-envelope',
    'Sms' => 'glyphicon-send'
  }

  def order_event_badge_for(event)
    glyphicon EVENTS_BADGES[event.event_type]
  end
end
