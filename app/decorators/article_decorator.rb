class ArticleDecorator < ApplicationDecorator
  decorates :article
  decorates_association :author

  def author_rss
    "#{article.author.email} (#{article.author.name})"
  end

  def body
    h.md(article.body)
  end

  def bottom(articles)
    if articles
      h.tag(:hr, :class => "separator") if article != articles.last
    else
      h.link_to "&laquo; There is more where that came from".html_safe,
        h.articles_path, :id => "back-link"
    end
  end
end
