class PageDecorator < ApplicationDecorator
  decorates :page

  def body
    h.md(page.body)
  end

end