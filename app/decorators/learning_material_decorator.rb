class LearningMaterialDecorator < ApplicationDecorator
  decorates :learning_material

  def full_description
    return learning_material.name if learning_material.description.blank?

    [ learning_material.name + ":",
      h.content_tag(:span, h.strip_tags(learning_material.description), :class => 'description')
    ].join(' ').html_safe
  end

  def url
    h.link_to learning_material.url, learning_material.url
  end
end