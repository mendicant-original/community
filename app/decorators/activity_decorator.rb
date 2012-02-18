class ActivityDecorator < ApplicationDecorator
  decorates :activity
  decorates_association :author

  def registration_button
    h.content_tag(:span, :class => "registration") do
      if activity.archived?
        ""
      elsif activity.registration_open?
        link_options = { method: :post, remote: true }

        if activity.approved_participants.include?(h.current_user)
          text = "Participating"
          link_options[:class]   = "cupid-blue"
          link_options[:title]   = "Click to stop participating"
          link_options[:rel]     = "twipsy"
          link_options[:confirm] = "Are you sure you want to stop participating?"
        elsif activity.users.include?(h.current_user)
          link_options[:class]   = "cupid-gray"
          text                   = "Applied"
          link_options[:title]   = "Click to remove your request"
          link_options[:rel]     = "twipsy"
          link_options[:confirm] = "Are you sure you want to remove your request?"
        else
          text                   = "Participate"
          link_options[:class]   = "cupid-dark-blue"
          link_options[:confirm] = "Are you sure you want to participate?"
        end

        h.link_to(text, h.register_activity_path(activity), link_options)
      else
        "Registration Closed"
      end
    end
  end

  def body
    h.md(activity.body)
  end

  def created_at
    h.l activity.created_at.to_date, :format => :long
  end

  def author_link
    "by #{h.link_to(activity.author.name, h.person_path(activity.author))}".html_safe
  end

  def discussion_list_link
    return unless activity.discussion_list

    "To discuss this activity, send an email to ".html_safe +
    h.mail_to(activity.discussion_list.email_address)
  end

  def participants_link
    participants = activity.approved_participants

    if participants.any?
      link = h.link_to h.pluralize(participants.count, 'participant'),
        h.activity_path(activity, :anchor => "participants")
    end

    h.content_tag(:div, link || "", :class => "participants").html_safe
  end

  def css_class
    css_class = []
    css_class << 'unread' unless activity.read_by?(h.current_user)

    css_class.join(' ')
  end
end
