class PeopleController < ApplicationController

  def index
    users = User.order("name").paginate(:page => params[:page], :per_page => 50)
    @people = UserDecorator.decorate(users)
  end

end
