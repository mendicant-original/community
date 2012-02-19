module ApplicationHelper

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
    MdPreview::Parser.parse(content)
  end

  def submit_link(name, form)
    link_to name, '#', :class => "clean-gray", :'data-submit' => form
  end

  def unread_count(count)
    content_tag(:span, count, :class => 'unread_count') if count > 0
  end
end
