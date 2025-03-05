require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @booking = bookings(:one)
    @horse = horses(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get bookings_url
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count', 1) do
      post horse_bookings_url(@horse), params: {
        booking: {
          start_date: Date.today,
          end_date: Date.today + 7,
          status: "pending",
          price_at_booking: 500
        }
      }
    end
    assert_redirected_to booking_url(@booking)
  end


  test "should show booking" do
    get booking_url(@booking)
    assert_response :success
  end

  test "should update booking" do
    patch booking_url(@booking), params: { booking: { start_date: Date.today, end_date: Date.today + 1.week } }
    assert_redirected_to booking_url(@booking)
  end
end
