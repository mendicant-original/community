class ProjectsController < ApplicationController
  before_filter :find_project, :only => [:show]

  def index
    @projects = Project.order("name").
                  paginate(:page => params[:page], :per_page => 50)
    @projects = ProjectDecorator.decorate(@projects)
  end

  private

  def find_project
    @project = Project.find_by_slug(params[:id])
  end
end
