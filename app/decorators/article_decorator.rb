class ArticleDecorator < ApplicationDecorator
  decorates :article
  decorates_association :author

  def author_rss
    "#{article.author.email} (#{article.author.name})"
  end

  def url_host
    URI.parse(article.url).host
  end

  def body
    h.md(article.body)
  end
end