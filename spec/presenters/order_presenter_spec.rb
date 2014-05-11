require 'spec_helper'

describe OrderPresenter do
  let(:presenter) do
    OrderPresenter.new(first_name: 'First',
                       last_name: 'Last',
                       email: 'test@ya.ru',
                       note: 'Note',
                       phone: '123456789',
                       street: 'Street',
                       city: 'City')
  end

  it "should validate email address" do
    presenter.email = 'invalid'
    presenter.valid?.should be_false

    presenter.email = 'test@example.com'
    presenter.valid?.should be_true
  end

  describe "#address" do
    it "should provide address object" do
      presenter.address.is_a? Address
    end
  end
  describe "#address=(address)" do
    it "should assign address" do
      address = Address.new(city: 'City', street: 'Street', phone: 'Phone')
      presenter.address = address

      presenter.city.should eq(address.city)
      presenter.street.should eq(address.street)
      presenter.phone.should eq(address.phone)
    end
  end

  describe "#update=(hash)" do
    it "should update OrderPresenter attributes" do
      h = {first_name: 'Another first', last_name: 'Another last'}
      presenter.update(h)

      presenter.first_name.should eq(h[:first_name])
      presenter.last_name.should eq(h[:last_name])
    end
  end
end
