require "test_helper"

class ConsultantControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get consultant_index_url
    assert_response :success
  end

  test "should get setup" do
    get consultant_setup_url
    assert_response :success
  end
end
