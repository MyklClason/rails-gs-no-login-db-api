require 'test_helper'

class SheetsControllerTest < ActionController::TestCase
  test "should get compute" do
    get :compute
    assert_response :success
  end

end
