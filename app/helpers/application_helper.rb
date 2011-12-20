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

  def error_messages_for(object)
    if object.errors.any?
      content_tag(:div, :id => "errorExplanation") do
        content_tag(:h2) { "Whoops, looks like something went wrong." } +
        content_tag(:p) { "Please review the form below and make the appropriate changes." } +
        content_tag(:ul) do
          object.errors.full_messages.map do |msg|
            content_tag(:li) { msg }
          end.join("\n").html_safe
        end
      end
    end
  end

  def md(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :autolink            => true,
      :space_after_headers => true,
      :no_intra_emphasis   => true,
      :fenced_code_blocks  => true)

    markdown.render(content).html_safe
  end

end