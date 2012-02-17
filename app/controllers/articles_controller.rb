class ArticlesController < ApplicationController
  respond_to :html

  before_filter :user_required,         :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_article,          :only => [:show, :edit, :update, :destroy]
  before_filter :authorized_users_only, :only => [:edit, :update, :destroy]
  before_filter :profile_required,      :only => [:new, :create]

  def index
    @articles = Article.includes(:author).newest.paginate(:page => params[:page])
    @articles = @articles.public_only unless signed_in?

    @articles = ArticleDecorator.decorate(@articles)

    respond_with(@articles) do |format|
      format.rss { render :layout => false }
    end
  end

  def show
    raise ActionController::RoutingError.new('Not Found') if @article.nil?

    return if !@article.public? && user_required

    @article = ArticleDecorator.decorate(@article)

    respond_with(@article)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.build(params[:article])

    if @article.save
      redirect_to(@article, :notice => 'Article was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to(@article, :notice => 'Article was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to(articles_path, :notice => 'Article was successfully destroyed.')
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

    raise ActionController::RoutingError.new('Not Found') unless @article
  end

  def profile_required
    if current_user.description.blank?
      flash[:error] = "Please add some information to your description and try again."
      redirect_to edit_person_path(current_user)
    end
  end
end
