require 'rack/test'
require 'rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.before(:all) do
    config  = YAML.load(ERB.new(File.read("./database.yml")).result)
    #ActiveRecord::Base.establish_connection(config["test"])
    ActiveRecord::Base.establish_connection(config[ENV['APP_ENV']])
  end
  config.after(:each) do
    ActiveRecord::Base.connection.close
  end
end
