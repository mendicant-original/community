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

  def full_description(include_user = true)
    return project.name if project.description.blank?

    [ project.name,
      h.content_tag(:span, :class => 'description') do
        [h.strip_tags(project.description), (from if include_user)].compact.join(" ")
      end
    ].join(' ').html_safe
  end

  def from
    ["from", project.user.name].join(" ") unless project.core_project
  end

  def submitted_by
    if project.core_project
      [ h.link_to("Mendicant University", "http://university.rubymendicant.com"),
        "Core Project"].join(" ")
    else
      ["Submitted by",
        h.link_to(project.user.name, h.person_path(project.user.github))
      ].join(" ")
    end.html_safe
  end

  def source
    return if project.source_url.blank?

    h.link_to "Source Code", project.source_url
  end
end