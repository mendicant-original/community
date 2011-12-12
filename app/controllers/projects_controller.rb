class ProjectsController < ApplicationController
  before_filter :find_project,              :only => admin_actions + [:show]
  before_filter :user_required,             :only => admin_actions
  before_filter :creator_or_admin_required, :only => admin_actions

  def index
    @projects = Project.order("name")

    if params[:filter]
      @projects = @projects.where("name ILIKE :filter OR description ILIKE :filter",
        :filter => "%#{params[:filter]}%"
      )
    end

    @projects = @projects.paginate(:page => params[:page], :per_page => 50)
    @projects = ProjectDecorator.decorate(@projects)

    respond_to do |format|
      format.js do
        @results = render_to_string(:partial => "projects").html_safe
        render 'shared/update_list'
      end
      format.html
    end
  end

  def show;end
  def edit;end

  def new
    @project = ProjectDecorator.decorate(Project.new)
  end

  def create
    @project = Project.new(params[:project])

    @project.user = current_user

    if @project.save
      flash[:notice] = "Project sucessfully created"
      @project = ProjectDecorator.find(@project.id)
      redirect_to @project.show_path
    else
      #TODO Handle Errors
      render :action => :new
    end
  end

  def update
    params[:project].delete(:user_id)

    if @project.model.update_attributes(params[:project])
      flash[:notice] = "Project sucessfully updated"
      @project = ProjectDecorator.find(@project.id)
      redirect_to @project.show_path
    else
      #TODO Handle Errors
      render :action => :edit
    end
  end

  def destroy
    @project.model.destroy

    flash[:notice] = "Project sucessfully destroyed"
    redirect_to projects_path
  end

  private

  def find_project
    if params[:person_id] && params[:id]
      @user    = User.find_by_github(params[:person_id])
      @project = Project.find_by_slug_and_user_id(params[:id], @user.id)
    elsif params[:id]
      @project = Project.find_by_slug_and_core_project(params[:id], true)
    else
      @project = Project.new(:user => current_user)
    end

    @project = ProjectDecorator.decorate(@project)
  end

  def creator_or_admin_required
    access_denied unless current_user.admin? || (@project.user == current_user)
  end

end
