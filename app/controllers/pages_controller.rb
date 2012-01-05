class PagesController < ApplicationController
  def show
    @page = PageDecorator.find_by_slug(params[:id]).decorate
  end
end
