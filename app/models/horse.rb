class Horse < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  has_many_attached :pictures

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  validates :name, :breed, :location, :stud_fee, presence: true
end
