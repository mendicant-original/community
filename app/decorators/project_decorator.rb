class ProjectDecorator < ApplicationDecorator
  decorates :project
  allows :can_edit?, :name, :description, :user, :source_url, :slug

  def show_path
    h.person_project_path(project.user.github, project.slug)
  end

  def edit_path
    h.edit_person_project_path(project.user.github, project.slug)
  end

  def path
    if project.new_record?
      h.person_projects_path(h.current_user.github)
    else
      show_path
    end
  end
end