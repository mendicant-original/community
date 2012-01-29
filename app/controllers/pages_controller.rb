class PagesController < ApplicationController
  def show
    @page = PageDecorator.find_by_slug(params[:id])

    raise ActionController::RoutingError.new('Not Found') unless @page
  end
end
