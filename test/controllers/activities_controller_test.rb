require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get activities" do
    get activities_activities_url
    assert_response :success
  end

end
