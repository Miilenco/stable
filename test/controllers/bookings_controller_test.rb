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

  test "should get new" do
    get new_horse_booking_url(horses(:one))
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post bookings_url, params: { booking: { horse_id: @horse.id, user_id: @user.id, start_date: Date.today, end_date: Date.today + 1.week } }
    end

    assert_redirected_to booking_url(Booking.last)
  end

  test "should show booking" do
    get booking_url(@booking)
    assert_response :success
  end

  test "should get edit" do
    get edit_booking_url(@booking)
    assert_response :success
  end

  test "should update booking" do
    patch booking_url(@booking), params: { booking: { start_date: Date.today, end_date: Date.today + 1.week } }
    assert_redirected_to booking_url(@booking)
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
end
