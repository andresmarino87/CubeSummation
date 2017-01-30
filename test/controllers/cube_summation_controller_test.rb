require 'test_helper'

class CubeSummationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cube_summation_index_url
    assert_response :success
  end

end
