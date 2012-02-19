require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryGirl.create(:user)
    @article = FactoryGirl.create(:article, title: "Restricted Unicorns!",
      public: false, author: @user)
  end

  test "articles can only be created by users with profiles" do
    sign_user_in(@user)

    visit new_article_path

    assert_current_path edit_person_path(@user)

    assert_flash "Please add some information to your description and try again."

    fill_in "Description", :with => "I love Mendicant University"

    click_button "Save"

    visit new_article_path

    assert_current_path new_article_path
  end

  test "guest cannot see non-public articles on index" do
    visit articles_path
    assert_no_content("Restricted Unicorns!s")
  end

  test "unicorns can see non-public articles on index" do
    sign_user_in(@user)
    visit articles_path
    assert_content("Restricted Unicorns!")
  end

  test "guest cannot access non-public articles" do
    visit article_path(@article)
    assert_current_path root_path
  end

  test "unicorns can access non-public articles" do
    sign_user_in(@user)
    visit article_path(@article)
    assert_content("Restricted Unicorns!")
  end

  test "unicorns see an unread article" do
    visit articles_path
    assert_no_content("1 Updates")

    sign_user_in(@user)
    assert_content("1 Updates")

    visit article_path(@article)
    assert_no_content("1 Updates")
  end
end
