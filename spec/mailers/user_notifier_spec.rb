require 'spec_helper'

describe UserNotifier do
  let(:user) { create(:user) }

  it 'should send registration email' do
    mail = UserNotifier.registered(user.id)
    expect(mail.to).to eq([user.email])
  end

  it 'should send email on automatic account creation' do
    password = '12345'
    mail = UserNotifier.account_created(user.id, password)
    expect(mail.to).to eq([user.email])
    expect(mail.body.encoded).to match(password)
  end
end
