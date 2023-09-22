class Message < ApplicationRecord
  belongs_to :user
  validates :recipient_phone, presence: true
  validates_length_of :text, maximum: 250
end
