require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(username: 'bwong45', email: 'bw@example.com', password: 'google')
    expect(user).to be_valid
  end

  it 'is not valid without a username' do
    user = User.new(email: 'bwong45', password: 'google')
    expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
    user = User.new(email: 'bw@example.com', password: 'google')
    expect(user).to_not be_valid
  end
end
