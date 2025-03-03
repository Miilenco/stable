class Horse < ApplicationRecord
  belongs_to :user

  validates :name, :breed, :location, :stud_fee, presence: true
end
