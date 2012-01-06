class Admin::PagesController < ApplicationController
  before_filter :admin_required
  before_filter :find_page

  def show
    @page = PageDecorator.find(@page)

    render 'pages/show'
  end

  def edit

  end

  def update
    if @page.update_attributes(params[:page])
      flash[:notice] = "Page updated"
      redirect_to admin_page_path(@page)
    else

    end
  end

  private

  def find_page
    @page = Page.find_by_slug(params[:id])
  end

  def admin_required
    unless current_user.try(:admin)
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
end
