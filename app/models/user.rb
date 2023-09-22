class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, if: :will_save_change_to_email?
end
