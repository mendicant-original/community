class ArticleDecorator < ApplicationDecorator
  decorates :article
  decorates_association :author

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

  def css
    css_classes = []

    css_classes << 'sticky'  if article.sticky?
    css_classes << 'private' unless article.public?
    css_classes << 'unread'  unless article.read_by?(h.current_user)

    css_classes.join(' ')
  end
end
