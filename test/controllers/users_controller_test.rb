require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url  # Correct helper for new action
    assert_response :success
  end

  test "should create user" do
    post users_url, params: { user: { first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password123' } }  # Correct helper for create action
    assert_response :redirect
  end
end

