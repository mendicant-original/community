module Support
  module Integration
    def assert_css(css, options={})
      assert has_css?(css, options),
        "CSS #{css.inspect} with options #{options.inspect} does not exist"
    end

    def assert_no_css(css)
      assert has_no_css?(css),
        "CSS #{css.inspect} exists in the page"
    end

    def assert_current_path(expected_path)
      assert_equal expected_path, current_path
    end

    def assert_errors(*error_list)
      within "#errorExplanation" do
        error_list.each do |error_message|
          assert_content error_message
        end
      end
    end

    def assert_field(label, options={})
      assert has_field?(label, options),
        "Field #{label.inspect} with options #{options.inspect} does not exist"
    end

    def assert_no_field(label, options={})
      assert has_no_field?(label, options),
        "Field #{label.inspect} with options #{options.inspect} exists"
    end

    def assert_flash(message)
      assert has_css?('#flash', :text => message),
        "Flash #{message.inspect} does not exist in the page"
    end

    def assert_no_flash(message)
      assert has_no_css?('#flash', :text => message),
        "Flash #{message.inspect} does exist in the page"
    end

    def assert_flash_alert
      assert has_css?('#alert'),
        "Flash alert does not exist in the page"
    end

    def assert_no_flash_alert
      assert has_no_css?('#alert'),
        "Flash alert exists in the page"
    end

    def assert_link(text, options={})
      assert has_link?(text, options), "Link #{text} does not exist in the page"
    end

    def assert_no_link(text)
      assert has_no_link?(text), "Link #{text} exists in the page"
    end

    def assert_content(content)
      assert has_content?(content), "Content #{content.inspect} does not exist"
    end

    def assert_no_content(content)
      assert has_no_content?(content), "Content #{content.inspect} exist"
    end

    def assert_title(title)
      assert has_css?('h1', :text => title),
        "Title #{title.inspect} does not exist"
    end

    def assert_image(src)
      assert has_css?('img', :src => "/images/#{src}"), "Image /images/#{src} does not exist"
    end

    def click_link_within(scope, text)
      within(scope) { click_link(text) }
    end

    def within(scope, prefix=nil)
      scope = '#' << ActionController::RecordIdentifier.dom_id(scope, prefix) if scope.is_a?(ActiveRecord::Base)
      super(scope)
    end
  end
end
