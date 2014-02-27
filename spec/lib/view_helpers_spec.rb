require 'spec_helper'

describe TrackableClick::ViewHelpers do
  before(:each) do
    config = mock
    application = mock
    application.stubs(:config).returns(config)
    Rails.stubs(:application).returns(application)
  end

  describe "when checking env for of click tracking" do
    it "returns the correct configuration value" do
      Rails.application.config.stubs(:tracking_clicks).returns(true)
      tracking_clicks?.should == true
    end

    it "does not track clicks when configured correctly" do
      Rails.application.config.stubs(:tracking_clicks).returns(false)

      did_track_clicks = false

      should_perform_tracking do
        did_track_clicks = true
      end

      did_track_clicks.should == false
    end

    it "does track clicks when configured correctly" do
      Rails.application.config.stubs(:tracking_clicks).returns(true)

      did_track_clicks = false

      should_perform_tracking do
        did_track_clicks = true
      end

      did_track_clicks.should == true
    end
  end

  describe "when adding a clickable item w/ a view helper" do
    before(:each) do
      Rails.application.config.stubs(:tracking_clicks).returns(true)
    end

    it "adds a submit tag correctly" do
      self.expects(:submit_tag)
      trackable_submit("Test", class: "test")
    end

    it "adds a link tag correctly" do
      self.expects(:link_to)
      trackable_link_to("Test", class: "test")
    end
  end
end