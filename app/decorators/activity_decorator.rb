class ActivityDecorator < ApplicationDecorator
  decorates :activity

  def registration_button
    h.content_tag(:span, :class => "registration") do
      if activity.registration_open?
        link_options = { method: :post, remote: true, class: "clean-gray" }

        if activity.approved_participants.include?(h.current_user)
          text = "You're Participating"
          link_options[:class] += " participating"
          link_options[:title]  = "Click to stop participating"
          link_options[:rel]    = "twipsy"
        elsif activity.users.include?(h.current_user)
          text                 = "Pending Approval"
          link_options[:title] = "Click to remove your request"
          link_options[:rel]   = "twipsy"
        else
          text = "Participate"
        end

        h.link_to(text, h.register_activity_path(activity), link_options)
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
