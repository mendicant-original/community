class PagesController < ApplicationController
  respond_to :html
  before_filter :find_page

  def show
    raise ActionController::RoutingError.new('Not Found') if @page.nil?

    respond_with(@page)
  end

  private

  def find_page
    @page = PageDecorator.find_by_slug(params[:id])

    user_required if @page && @page.protected?
  end
end
