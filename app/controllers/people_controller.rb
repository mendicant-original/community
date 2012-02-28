class PeopleController < ApplicationController
  respond_to :html

  def show
    @person = UserDecorator.find_by_github(params[:id])

    raise ActionController::RoutingError.new('Not Found') unless @person

    @person = @person.decorate

    respond_with(@person)
  end

  def edit
    @person = current_user
  end

  def update
    @person = current_user

    if @person.update_attributes(params[:user])
      flash[:notice] = "Profile sucessfully updated"
      redirect_to person_path(@person)
    else
      render :action => :edit
    end
  end

  def read_all
    params[:type].classify.constantize.read_all(current_user)

    redirect_to :back
  end

end
