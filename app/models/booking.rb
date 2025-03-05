class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :horse

  enum status: { pending: 0, accepted: 1, declined: 2, cancelled: 3, completed: 4 }

  validates :start_date, :end_date, :price_at_booking, :status, presence: true
  validate :end_date_after_start_date

  validate :cannot_book_own_horse

  after_initialize :set_default_status,  if: :new_record?

  private

  def set_default_status
    self.status ||= :pending
  end

  def cannot_book_own_horse
    return if horse.nil? || user.nil? # Prevents undefined method errors

    if horse.user == user
      errors.add(:user, "cannot book your own horse")
    end
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after the start date") if end_date <= start_date
  end
end
