class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one) # Assuming you have a fixture for users
  end

  test "should create user" do
    assert_difference("User.count", 1) do
      post users_url, params: { user: {
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password",
        password_confirmation: "password"
      } }
    end
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end
end
