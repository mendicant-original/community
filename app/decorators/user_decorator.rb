require 'digest/md5'

class UserDecorator < ApplicationDecorator
  decorates :user

  def icon(size=32)
    return h.content_tag(:div, '', :class => "icon") if user.email.blank?

    hash = Digest::MD5.hexdigest(user.email.downcase)

    h.image_tag("http://www.gravatar.com/avatar/#{hash}?s=#{size}")
  end

  def full_description
    return user.name if user.description.blank?

    [ user.name,
      h.content_tag(:span, h.strip_tags(user.description), :class => 'description')
    ].join(' ').html_safe
  end

  def github_link
    return if user.github.blank?

    h.link_to user.github, "https://github.com/#{user.github}",
      :class => "btn-auth btn-github"
  end

  def twitter_link
    return if user.twitter.blank?

    h.link_to user.twitter, "https://twitter.com/#{user.twitter}",
      :class => "btn-auth btn-twitter"
  end

  def website
    return if user.website.blank?

    h.link_to user.website, "http://#{user.website}", :class => "clean-gray"
  end

  def projects
    projects = user.projects.where(:core_project => false).order("name").limit(5)
    ProjectDecorator.decorate(projects)
  end

end