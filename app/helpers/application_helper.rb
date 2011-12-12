module ApplicationHelper

  def filter_list(path, &block)
    content_for(:header_bottom) do
      javascript_tag do
        %{$(function(){
          Filter.init('search', '#{path}');
        });}
      end
    end

    content_tag(:div, {:class => "filters"}, false) do
      [
        search_field_tag(:search, nil, :results => 0, :autocomplete => "off"),
        (capture(&block) if block_given?)
      ].join.html_safe
    end
  end

end