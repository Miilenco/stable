require "test_helper"

class HorsesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @horse = horses(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get horses_url
    assert_response :success
  end

  test "should get new" do
    get new_horse_url
    assert_response :success
  end

  test "should create horse" do
    assert_difference('Horse.count') do
      post horses_url, params: { horse: { name: 'New Horse', breed: 'Thoroughbred', age: 3, location: 'Stable', stud_fee: 1000.0, pedigree: 'Pedigree Info', progeny_success: 'Success Info', race_record: 'Record Info' } }
    end
    assert_redirected_to horse_url(Horse.last)
  end

  test "should show horse" do
    get horse_url(@horse)
    assert_response :success
  end

  test "should get edit" do
    get edit_horse_url(@horse)
    assert_response :success
  end

  test "should update horse" do
    patch horse_url(@horse), params: { horse: { name: 'Updated Horse', breed: 'Updated Breed', age: 4, location: 'Updated Location', stud_fee: 2000.0, pedigree: 'Updated Pedigree Info', progeny_success: 'Updated Success Info', race_record: 'Updated Record Info' } }
    assert_redirected_to horse_url(@horse)
  end

  test "should destroy horse" do
    assert_difference('Horse.count', -1) do
      delete horse_url(@horse)
    end
    assert_redirected_to horses_url
  end
end
