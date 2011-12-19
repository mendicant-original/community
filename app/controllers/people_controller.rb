class PeopleController < ApplicationController
  add_crumb("People") { |instance| instance.send :people_path }

  def index
    users = User.order("name")

    unless params[:filter].blank?
      users = users.where("name ILIKE :filter OR description ILIKE :filter",
        :filter => "%#{params[:filter]}%"
      )
    end

    users = users.paginate(:page => params[:page], :per_page => 20)

    @people = UserDecorator.decorate(users)

    respond_to do |format|
      format.js do
        @results = render_to_string(:partial => "people").html_safe
        render 'shared/update_list'
      end
      format.html
    end
  end

  def show
    @person = UserDecorator.find_by_github(params[:id]).decorate
    add_crumb @person.name, person_path(@person.github)
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
