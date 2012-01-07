require 'digest/md5'

class UserDecorator < ApplicationDecorator
  decorates :user

  def icon(size=32)
    image_path = h.image_path("avatar.png")

    unless user.email.blank?
      hash       = Digest::MD5.hexdigest(user.email.downcase)
      default    = CGI.escape("http://#{h.request.host_with_port}#{image_path}")
      image_path = "http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=#{default}"
    end

    # Manually set height / width so layouts don't collapse while gravatars are
    # loading
    #
    h.image_tag(image_path, :alt => user.name,
      :style => "width: #{size}px; height: #{size}px;")
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