class ProjectsController < ApplicationController
  before_filter :find_project,              :only => [:show]
  before_filter :user_required,             :only => admin_actions
  before_filter :creator_or_admin_required, :only => admin_actions

  def index
    @projects = Project.order("name").
                  paginate(:page => params[:page], :per_page => 50)
    @projects = ProjectDecorator.decorate(@projects)
  end

  def new
    @project = Project.new
  end

  private

  def find_project
    @project = Project.find_by_slug(params[:id])
  end

  def creator_or_admin_required
    access_denied unless current_user.admin? || @project.user == current_user
  end

end
