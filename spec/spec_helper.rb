require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ruuid/mongoid'

MODELS = File.expand_path('../app/models', __FILE__)
$LOAD_PATH.unshift MODELS

# These environment variables can be set if wanting to test against a database
# that is not on the local machine.
ENV['RUUID_MONGOID_SPEC_URL'] ||= 'mongodb://127.0.0.1:27017/ruuid_mongoid_test'

Mongoid.configure do |config|
  config.load_configuration(
    sessions: {
      default: {
        uri: ENV['RUUID_MONGOID_SPEC_URL']
      }
    }
  )
end

Dir[File.join(MODELS, '*.rb')].sort.each do |file|
  name = File.basename(file, '.rb')
  autoload name.camelize.to_sym, name
end

RSpec.configure do |config|
  config.before(:each) do
    Mongoid.purge!
  end
end
