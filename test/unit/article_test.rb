require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new
    @user = FactoryGirl.create(:user)
  end

  test "needs title" do
    @article.valid?
    assert @article.errors.include?(:title)
  end

  test "needs body" do
    @article.valid?
    assert @article.errors.include?(:body)
  end

  test "needs author" do
    @article.valid?
    assert @article.errors.include?(:author)
  end

  test "slug limits to 40 chars" do
    @article.title = 'a' * 50
    @article.valid?
    assert_equal(40, @article.slug.length)
  end

  test "newest lists from newer to older" do
    FactoryGirl.create(:article, title: "Article #1", author: @user)
    FactoryGirl.create(:article, title: "Article #2", author: @user)
    titles = Article.newest.map { |a| a.title }

    assert_equal(["Article #2", "Article #1"], titles)
  end

  test "sticky appears at the top" do
    FactoryGirl.create(:article, title: "Article #1", author: @user)
    FactoryGirl.create(:article, title: "Article #2", author: @user, sticky: true)
    FactoryGirl.create(:article, title: "Article #3", author: @user)
    titles = Article.newest.map { |a| a.title }

    assert_equal(["Article #2", "Article #3", "Article #1"], titles)
  end

  test "sticky respects pagination" do
    FactoryGirl.create(:article, title: "Article #1", author: @user)
    FactoryGirl.create(:article, title: "Article #2", author: @user, sticky: true)
    FactoryGirl.create(:article, title: "Article #3", author: @user)
    titles = Article.newest.paginate(per_page: 2, page: 2).map { |a| a.title }

    assert_equal(["Article #1"], titles)
  end

  test "list only public articles" do
    FactoryGirl.create(:article, title: "Article #1", author: @user)
    FactoryGirl.create(:article, title: "Article #2", author: @user, public_access: false)

    assert_equal(1, Article.public_only.count)
  end
end