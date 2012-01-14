class ActivityDecorator < ApplicationDecorator
  decorates :activity

  def registration_button
    h.content_tag(:span, :class => "registration") do
      if activity.registration_open?
        if activity.approved_participants.include?(h.current_user)
          text = "You're Participating"
          css_class = "participating"
          title = "Drop out"
        elsif activity.users.include?(h.current_user)
          text = "Pending Approval"
          title = "Drop out"
        else
          text = "Participate"
          title = "Join in"
        end

        h.link_to(text, h.register_activity_path(activity),
          :class => "clean-gray #{css_class if css_class}",
          :rel   => "twipsy", :title => title,
          :method => :post, :remote => true)
      else
        "Registration Closed"
      end
    end
  end

  def created_at
    h.l activity.created_at.to_date, :format => :long
  end

  def author_link
    "by #{h.link_to(activity.author.name, h.person_path(activity.author))}".html_safe
  end

  def participants_link
    participants = activity.approved_participants

    if participants.any?
      link = h.link_to h.pluralize(participants.count, 'participant'),
        h.activity_path(activity, :anchor => "participants")
    end

    h.content_tag(:div, link || "", :class => "participants").html_safe
  end
end
