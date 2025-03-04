class Horse < ApplicationRecord
  belongs_to :user

  has_many_attached :pictures

  validates :name, :breed, :location, :stud_fee, presence: true
end
