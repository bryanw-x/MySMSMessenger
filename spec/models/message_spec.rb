require 'rails_helper'

RSpec.describe Message, type: :model do
 let(:user) { User.create(username: 'bwong45', email: 'bw@example.com', password: 'google') }

  it 'is valid with valid attributes' do
    message = Message.new(
      recipient_phone: '1234567890',
      text: 'This is a test message',
      user: user
    )
    expect(message).to be_valid
  end

  it 'is not valid without a number' do
    message = Message.new(
      text: 'This is a test message',
      user: user
    )
    expect(message).to_not be_valid
  end

  it 'is not valid if text exceeds 250 characters' do
    message = Message.new(
      recipient_phone: '1234567890',
      text: 'A' * 251,
      user: user
    )
    expect(message).to_not be_valid
  end

  it 'is not valid without text' do
    message = Message.new(
      recipient_phone: '1234567890',
      user: user
    )
    expect(message).to_not be_valid
  end
end
