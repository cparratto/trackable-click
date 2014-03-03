module TrackableClick
  module ViewHelpers
    def tracking_clicks?
      Rails.configuration.tracking_clicks
    end

    def should_perform_tracking
      if block_given? && tracking_clicks?
        yield
      end
    end

    def trackable_submit(value, options = {})
      expand_options!(options) if tracking_clicks?
      submit_tag(value, options)
    end

    def trackable_link_to(name = nil, options = nil, html_options = nil, &block)
      expand_options!(options) if tracking_clicks?
      link_to(name, options, html_options, block)
    end

    private

    def expand_options!(options)
      options[:class] = make_trackable_class_from_options(options)
      fp_pixel_data_attrs = make_fp_pixel_data_attrs_from_options!(options)
      google_event_attrs = make_google_event_data_attrs_from_options!(options)
      google_commerce_attrs = make_google_commerce_data_attrs_from_options!(options)

      options[:data] ||= {}
      options[:data].merge!(fp_pixel_data_attrs)
      options[:data].merge!(google_event_attrs)
      options[:data].merge!(google_commerce_attrs)
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
         data_attrs[:tc_fb_pixel_only_if] = fp_pixel_options[:only_if]
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
         data_attrs[:tc_google_event_only_if] = google_event_options[:only_if]
         data_attrs[:tc_google_event_action] = google_event_options[:action]
         data_attrs[:tc_google_event_label] = google_event_options[:label]

         if google_event_options[:value]
           data_attrs[:google_event_value] = google_event_options[:value]
         end
       end

       options.delete(:google_event)
       data_attrs
    end

    def make_google_commerce_data_attrs_from_options!(options)
      data_attrs = {}
      google_commerce_options = options[:google_commerce]

      unless google_commerce_options.nil?
        data_attrs[:tc_google_commerce_only_if] = google_commerce_options[:only_if]
        data_attrs[:tc_google_commerce_id] = google_commerce_options[:id]
        data_attrs[:tc_google_commerce_affiliation] =google_commerce_options[:affiliation]
        data_attrs[:tc_google_commerce_revenue] = google_commerce_options[:revenue]
        data_attrs[:tc_google_commerce_shipping] = google_commerce_options[:shipping]
        data_attrs[:tc_google_commerce_tax] = google_commerce_options[:tax]
      end

      options.delete(:google_commerce)
      data_attrs
    end
  end
end