class Message < ApplicationRecord
  belongs_to :user
  validates :recipient_phone, presence: true, format: { with: /\d{10}/, message: "Valid number needed" }
  validates_length_of :text, maximum: 250
  validates :text, presence: true, length: { maximum: 250 }
end
