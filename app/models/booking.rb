class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :horse

  enum status: { pending: 0, accepted: 1, declined: 2 }

  validates :start_date, :end_date, :price_at_booking, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date <= start_date
  end
end
