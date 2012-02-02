require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test "non-existent user's profile page should throw 404" do
    get person_path(id: 'random')

    assert_response :missing
  end

  test "existent user's profile should be 200" do
    @user = Factory(:user)

    get person_path(id: @user.github)

    assert_response :success
  end
end
