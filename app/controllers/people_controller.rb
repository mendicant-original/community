class PeopleController < ApplicationController

  def show
    @person = UserDecorator.find_by_github(params[:id])

    raise ActiveRecord::RecordNotFound unless @person

    @person = @person.decorate
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

end
