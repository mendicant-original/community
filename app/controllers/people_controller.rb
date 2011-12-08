class PeopleController < ApplicationController

  def index
    users   = User.order("regexp_replace(name, '^.* ', '')").
                paginate(:page => params[:page], :per_page => 50)
    @people = UserDecorator.decorate(users)
  end

  def show
    @person = UserDecorator.find_by_github(params[:id]).decorate
  end

  def edit
    @person = current_user
  end

  def update
    @person = current_user

    if @person.update_attributes(params[:user])
      flash[:notice] = "Profile sucessfully updated"
      redirect_to edit_person_path(@person.github)
    else
      render :action => :edit
    end
  end

end
