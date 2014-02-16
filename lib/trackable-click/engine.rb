module TrackableClick
  class Engine < ::Rails::Engine
    isolate_namespace TrackableClick

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    initializer "trackable-click.view_helpers" do |app|
      ::ActionView::Base.send :include, ::TrackableClick::ViewHelpers
    end
  end
end