class ArticlesController < ApplicationController
  before_filter :user_required,         :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_article,          :only => [:show, :edit, :update, :destroy]
  before_filter :authorized_users_only, :only => [:edit, :update, :destroy]

  def index
    @articles = Article.includes(:author).order("created_at desc").
                  paginate(:page => params[:page])
    @articles = ArticleDecorator.decorate(@articles)

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @article = ArticleDecorator.decorate(@article)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.build(params[:article])

    if @article.save
      redirect_to(root_path, :notice => 'Article was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to(root_path, :notice => 'Article was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to(root_path, :notice => 'Article was successfully destroyed.')
  end

  private

  def authorized_users_only
    unless @article.editable_by?(current_user)
      redirect_to root_path,
        :alert => "You are not authorized to edit other user's articles!"
    end
  end

  def find_article
    @article = Article.find_by_slug(params[:id])
  end
end
