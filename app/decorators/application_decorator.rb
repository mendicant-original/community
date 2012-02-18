class ApplicationDecorator < Draper::Base
  def bottom(collection, collection_path)
    if collection
      h.tag(:hr, :class => "separator") if model != collection.last
    else
      h.link_to "&laquo; There is more where that came from".html_safe,
        collection_path, :id => "back-link"
    end
  end
end