require 'test_helper'

class ActivtiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get activties_index_url
    assert_response :success
  end

end
