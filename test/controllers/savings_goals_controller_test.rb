require "test_helper"

class SavingsGoalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get savings_goals_index_url
    assert_response :success
  end

  test "should get new" do
    get savings_goals_new_url
    assert_response :success
  end

  test "should get create" do
    get savings_goals_create_url
    assert_response :success
  end

  test "should get edit" do
    get savings_goals_edit_url
    assert_response :success
  end

  test "should get update" do
    get savings_goals_update_url
    assert_response :success
  end

  test "should get destroy" do
    get savings_goals_destroy_url
    assert_response :success
  end

  test "should get deposit" do
    get savings_goals_deposit_url
    assert_response :success
  end
end
