require "test_helper"

class HorsesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
test "should get index" do
  get horses_url
  assert_response :success
end

test "should create horse" do
  assert_difference('Horse.count') do
    post horses_url, params: { horse: { name: 'New Horse', breed: 'Thoroughbred' } }
  end
  assert_redirected_to horse_url(Horse.last)
end

test "should show horse" do
  horse = horses(:one)
  get horse_url(horse)
  assert_response :success
end

test "should update horse" do
  horse = horses(:one)
  patch horse_url(horse), params: { horse: { name: 'Updated Horse' } }
  assert_redirected_to horse_url(horse)
end

test "should destroy horse" do
  horse = horses(:one)
  assert_difference('Horse.count', -1) do
    delete horse_url(horse)
  end
  assert_redirected_to horses_url
end


