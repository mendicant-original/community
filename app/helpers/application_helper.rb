module ApplicationHelper

  def filter_list(&block)
    content_tag(:div, {:class => "filters"}, false) do
      [
        search_field_tag(:search),
        capture(&block)
      ].join.html_safe
    end
  end

end