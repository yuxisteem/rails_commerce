require 'spec_helper'

describe OrderNotifier do
  let(:order) { create(:order) }

  describe 'order received' do
    let(:mail) { OrderNotifier.order_received(order.id) }

    it 'should send order received mail' do
      expect(mail.to).to eq([order.user.email])
    end

    it 'should have valid link to order' do
      expect(mail.body.encoded).to match(order_url(id: order.code))
    end
  end

  describe 'order shipped' do
    it 'should send order shipped mail' do
      mail = OrderNotifier.order_shipped(order.id)
      expect(mail.to).to eq([order.user.email])
    end
  end
end
