require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) do
    {
      recipient_phone: '1234567890',
      text: 'Test'
    }
  end

  let(:invalid_attributes) do
    {
      recipient_phone: 'invalid_phone_number',
      text: nil
    }
  end

  let(:user) { User.create(username: 'bwong45', email: 'bw@example.com', password: 'google') }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new message' do
        sign_in user
        expect do
          post :create, params: { message: valid_attributes }
        end.to change(Message, :count).by(1)
      end

      it 'redirects to the messages path' do
        sign_in user
        post :create, params: { message: valid_attributes }
        expect(response).to redirect_to(messages_path)
      end
    end

    context 'with both invalid number and blank text' do
      it 'raises an error for invalid phone number' do
        sign_in user
        expect do
          post :create, params: { message: invalid_attributes }
        end.to raise_error(RuntimeError, 'Error while saving the message')
      end
    end
  end
end
