require "test_helper"

class PlannerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get planner_index_url
    assert_response :success
  end

  test "should get new" do
    get planner_new_url
    assert_response :success
  end

  test "should get create" do
    get planner_create_url
    assert_response :success
  end

  test "should get toggle" do
    get planner_toggle_url
    assert_response :success
  end

  test "should get destroy" do
    get planner_destroy_url
    assert_response :success
  end
end
