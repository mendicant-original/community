class PagesController < ApplicationController
  respond_to :html

  def show
    @page = PageDecorator.find_by_slug(params[:id])

    raise ActionController::RoutingError.new('Not Found') if @page.nil?

    return if @page && @page.protected? && user_required

    respond_with(@page)
  end
end
