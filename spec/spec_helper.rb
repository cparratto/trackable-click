ENV["RAILS_ENV"] ||= 'test'
require 'trackable-click/view_helpers'
require 'rails/all'
require 'rspec/rails'
require 'rspec/autorun'

RSpec.configure do |config|
  config.include TrackableClick::ViewHelpers
  config.mock_with :mocha
end