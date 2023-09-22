class Message < ApplicationRecord
  belongs_to :user
  validates :recipient_phone, presence: true
end
