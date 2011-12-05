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
        ["is a", h.strip_tags(user.description)].join(' ')
      end
    ].join(' ').html_safe
  end
end