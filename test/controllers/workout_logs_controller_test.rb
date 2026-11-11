require "test_helper"

class WorkoutLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get workout_logs_create_url
    assert_response :success
  end
end
