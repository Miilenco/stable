class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show update]

  def index
    # Show bookings for the current user (both requested & received)
    @my_requests = current_user.bookings
    @incoming_requests = Booking.joins(:horse).where(horses: { user_id: current_user.id })
  end

  def show
  end

  def create
    @booking = @horse.bookings.build(booking_params)
    @booking.user = current_user
    @booking.price_at_booking = @horse.stud_fee # Ensures correct price is stored

    if @booking.save
      redirect_to @booking, notice: "Booking request submitted!"
    else
      render "horses/show", status: :unprocessable_entity
    end
  end

  # No edit needed unless we want booking requesters to be able to edit their booking requests

  def update
    # Stallion owner updates booking status (Accept/Decline)
    if params[:status].present? && Booking.statuses.keys.include?(params[:status])
      @booking.update(status: params[:status])
      redirect_to @booking, notice: "Booking #{params[:status]}!"
    else
      redirect_to @booking, alert: "Invalid status update"
    end
  end

  # No delete. Status can be changed to cancelled or declined

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:horse_id, :start_date, :end_date, :price_at_booking)
  end
end
