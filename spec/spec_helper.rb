$LOAD_PATH.unshift File.dirname(__FILE__)
require 'rspec'
require 'currency_converter'

RSpec.configure do |config|
  config.order = "rand"
end
