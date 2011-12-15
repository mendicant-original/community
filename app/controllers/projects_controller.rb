class ProjectsController < ApplicationController
  add_crumb("Projects") { |instance| instance.send :projects_path }

  before_filter :find_project,              :only => admin_actions + [:show]
  before_filter :user_required,             :only => admin_actions
  before_filter :creator_or_admin_required, :only => admin_actions

  def index
    @projects = Project.order("name")

    unless params[:filter].blank?
      @projects = @projects.where("name ILIKE :filter OR description ILIKE :filter",
        :filter => "%#{params[:filter]}%"
      )
    end

    @projects = @projects.paginate(:page => params[:page], :per_page => 20)
    @projects = ProjectDecorator.decorate(@projects)

    respond_to do |format|
      format.js do
        @results = render_to_string(:partial => "projects").html_safe
        render 'shared/update_list'
      end
      format.html
    end
  end

  def show
    @project = ProjectDecorator.decorate(@project)

    add_crumb(@project.name, @project.show_path)
  end

  def edit;end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])

    @project.user = current_user

    if @project.save
      flash[:notice] = "Project sucessfully created"
      redirect_to ProjectDecorator.find(@project.id).show_path
    else
      render :action => :new
    end
  end

  def update
    params[:project].delete(:user_id)

    if @project.update_attributes(params[:project])
      flash[:notice] = "Project sucessfully updated"
      redirect_to ProjectDecorator.find(@project.id).show_path
    else
      render :action => :edit
    end
  end

  def destroy
    @project.destroy

    flash[:notice] = "Project sucessfully destroyed"
    redirect_to projects_path
  end

  private

  def find_project
    if params[:person_id] && params[:id]
      @user    = User.find_by_github(params[:person_id])
      @project = Project.find_by_slug_and_user_id(params[:id], @user.id)

      add_crumb(@user.name, person_path(@user.github))
    elsif params[:id]
      @project = Project.find_by_slug_and_core_project(params[:id], true)
    else
      @project = Project.new(:user => current_user)
    end
  end

  def creator_or_admin_required
    access_denied unless current_user.admin? || (@project.user == current_user)
  end

end
