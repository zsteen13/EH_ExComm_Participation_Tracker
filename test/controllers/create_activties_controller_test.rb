require 'test_helper'

class CreateActivtiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get create_activties_index_url
    assert_response :success
  end

  test "should get request" do
    get create_activties_request_url
    assert_response :success
  end

  test "should get confirmation" do
    get create_activties_confirmation_url
    assert_response :success
  end

end
