require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest
  test "articles can only be created by users with profiles" do
    user = sign_user_in

    visit new_article_path

    assert_current_path edit_person_path(user)

    assert_flash "Please add some information to your description and try again."

    fill_in "Description", :with => "I love Mendicant University"

    click_button "Save"

    visit new_article_path

    assert_current_path new_article_path
  end
end