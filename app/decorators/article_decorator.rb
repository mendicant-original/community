class ArticleDecorator < ApplicationDecorator
  decorates :article
  decorates_association :author

  # Needed for helpers.capture
  #
  helpers.extend(Haml::Helpers)
  helpers.init_haml_helpers

  def author_rss
    "#{article.author.email} (#{article.author.name})"
  end

  def body
    h.md(article.body)
  end

  def twitter
    via = "via @" + article.author.twitter unless article.author.twitter.blank?
    url = short_url

    tweet     = [url, via].compact.join(' ')
    remaining = 160 - tweet.length - 1

    tweet = [title[0..remaining], tweet].join(' ')

    tweet
  end

  def short_url
    url = Rails.application.routes.url_helpers.
      article_url(article, :host => "community.mendicantuniversity.org").gsub(/\Ahttp:\/\//, '')

    RestClient.post("http://is.gd/create.php", :format => "simple", :url => url)
  end

  def div(&block)
    css_class = []
    css_class << 'sticky' if article.sticky?
    css_class << 'unread' unless article.read_by?(h.current_user)

    h.content_tag_for(:article, article, :class => css_class.join(' ')) do
      h.capture(&block)
    end
  end
end
