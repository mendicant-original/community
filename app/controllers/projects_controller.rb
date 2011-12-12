class ProjectsController < ApplicationController
  before_filter :find_project,              :only => admin_actions + [:show]
  before_filter :user_required,             :only => admin_actions
  before_filter :creator_or_admin_required, :only => admin_actions

  def index
    @projects = Project.order("name").
                  paginate(:page => params[:page], :per_page => 50)
    @projects = ProjectDecorator.decorate(@projects)
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
    if params[:id]
      @user    = User.find_by_github(params[:person_id])
      @project = Project.find_by_slug_and_user_id(params[:id], @user.id)
      @project = ProjectDecorator.decorate(@project)
    else
      @project = Project.new(:user => current_user)
    end
  end

  def creator_or_admin_required
    access_denied unless current_user.admin? || (@project.user == current_user)
  end

end
