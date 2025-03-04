class Horse < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, :breed, :location, :stud_fee, presence: true
end
