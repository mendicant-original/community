class PagesController < ApplicationController
  def show
    @page = PageDecorator.find_by_slug(params[:id])

    if @page.nil?
      raise ActionController::RoutingError.new('Not Found')
    elsif @page.protected?
      user_required
    end
  end
end
