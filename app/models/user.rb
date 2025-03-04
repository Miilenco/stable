class User < ApplicationRecord
  has_many :horses
  has_many :bookings

  validates :first_name, :last_name, presence: true, length: { minimum: 3 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
