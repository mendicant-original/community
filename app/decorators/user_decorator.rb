require 'digest/md5'

class UserDecorator < ApplicationDecorator
  decorates :user

  def icon(size=32)
    hash = Digest::MD5.hexdigest(user.email.downcase)

    h.image_tag("http://www.gravatar.com/avatar/#{hash}?s=#{size}")
  end

  def description
    return user.name if user.description.blank?

    [ user.name,
      h.content_tag(:span, :class => 'description') do
        ["-", h.strip_tags(user.description)].join(' ')
      end
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

    h.link_to user.website, "http://#{user.website}", :class => "btn-auth"
  end
end