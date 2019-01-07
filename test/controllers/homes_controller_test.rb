require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get homes_index_url
    assert_response :success
  end

  test "should get use" do
    get homes_use_url
    assert_response :success
  end

  test "should get protect" do
    get homes_protect_url
    assert_response :success
  end

end
