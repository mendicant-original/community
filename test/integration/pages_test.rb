require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  test "pages are browsable using their slugs" do
    page = Page.create(:title => "Regular page", :body => "# Welcome guest!")

    visit page_path(page.slug)

    assert_title "Welcome guest!"
  end

  test "protected pages require a user to be logged in" do
    page = Page.create(title: "Regular page", body: "# Welcome friend!",
                       protected: true)

    visit page_path(page.slug)

    assert_no_content "Welcome friend!"

    sign_user_in

    visit page_path(page.slug)

    assert_content "Welcome friend!"
  end
end