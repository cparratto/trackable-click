module TrackableClick
  module ViewHelpers
    def trackable_submit(value, options = {})
      expand_options!(options)
      submit_tag(value, options)
    end

    def trackable_click_tag(name, content_or_options_with_block = nil, opts = nil, escape = true, &block)
      expand_options!(options)
      content_tag(name, content_or_options_with_block, opts, escape, block)
    end

    def trackable_link_to(name = nil, options = nil, html_options = nil, &block)
      expand_options!(options)
      link_to(name, options, html_options, block)
    end

    private

    def expand_options!(options)
      options[:class] = make_trackable_class_from_options(options)
      fp_pixel_data_attrs = make_fp_pixel_data_attrs_from_options!(options)
      google_event_attrs = make_google_event_data_attrs_from_options!(options)

      options[:data] ||= {}
      options[:data].merge!(fp_pixel_data_attrs)
      options[:data].merge!(google_event_attrs)
    end

    def make_trackable_class_from_options(options)
      css_class = options[:class] || ""
      css_class << " trackable-click"
      css_class
    end

    def make_fp_pixel_data_attrs_from_options!(options)
      data_attrs = {}
      fp_pixel_options = options[:fp_pixel]

      unless fp_pixel_options.nil?
         data_attrs[:tc_fb_pixel_id] = fp_pixel_options[:id]
         data_attrs[:tc_fb_pixel_value] = fp_pixel_options[:value]
         data_attrs[:tc_fb_pixel_currency] = fp_pixel_options[:currency]
      end

      options.delete(:fp_pixel)
      data_attrs
    end

    def make_google_event_data_attrs_from_options!(options)
       data_attrs = {}
       google_event_options = options[:google_event]

       unless google_event_options.nil?
         data_attrs[:tc_google_event_action] = google_event_options[:action]
         data_attrs[:tc_google_event_label] = google_event_options[:label]

         if google_event_options[:value]
           data_attrs[:google_event_value] = google_event_options[:value]
         end
       end

       options.delete(:google_event)
       data_attrs
    end
  end
end