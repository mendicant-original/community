require 'digest/md5'

class UserDecorator < ApplicationDecorator
  decorates :user

  def icon(size=32)
    return h.content_tag(:div, '', :class => "icon") if user.email.blank?

    hash = Digest::MD5.hexdigest(user.email.downcase)

    h.image_tag("http://www.gravatar.com/avatar/#{hash}?s=#{size}")
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

  def website_link
    return if user.website.blank?

    h.link_to user.website, "http://#{user.website}",
      :class => "btn-auth btn-web"
  end

  def description
    h.md(user.description)
  end

end