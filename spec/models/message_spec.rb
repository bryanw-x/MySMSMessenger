require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(username: 'bwong45', email: 'bw@example.com', password: 'google')
    message = Message.new(
      recipient_phone: '1234567890',
      text: 'This is a test message',
      user: user
    )
    expect(message).to be_valid
  end

  it 'is not valid without a number' do
    user = User.create(username: 'bwong45', email: 'bw@example.com', password: 'google')
    message = Message.new(
      text: 'This is a test message',
      user: user
    )
    expect(message).to_not be_valid
  end

  it 'is not valid if text exceeds 250 characters' do
      user = User.new(email: 'bwong45', password: 'google')
      message = Message.new(
      recipient_phone: '1234567890',
      text: 'A' * 251,
      user: user
    )
    expect(message).to_not be_valid
  end
end
