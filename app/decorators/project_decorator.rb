class ProjectDecorator < ApplicationDecorator
  decorates :project
  allows :can_edit?, :name, :description, :user, :source_url, :slug, :core_project

  def show_path
    if project.core_project
      h.project_path(project.slug)
    else
      h.person_project_path(project.user.github, project.slug)
    end
  end

  def edit_path
    if project.core_project
      h.edit_project_path(project.slug)
    else
      h.edit_person_project_path(project.user.github, project.slug)
    end
  end

  def path
    if project.new_record?
      h.person_projects_path(h.current_user.github)
    else
      show_path
    end
  end

  def full_description
    return project.name if project.description.blank?

    [ project.name,
      h.content_tag(:span, h.strip_tags(project.description), :class => 'description')
    ].join(' ').html_safe
  end

  def source
    return if project.source_url.blank?

    h.link_to "Source Code", project.source_url
  end
end