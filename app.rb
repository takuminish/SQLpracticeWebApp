require 'sinatra'
require 'sinatra/reloader'
require 'mysql2'
require 'dotenv'
require 'yaml'
require 'erb'

set :bind, '0.0.0.0'
Dotenv.load
yaml_file = File.read("database.yml")
sql_client = Mysql2::Client.new(YAML.load(ERB.new(yaml_file).result))

get '/' do
  'Welcome to Sinatra!!'
  query = "show tables"

  sql_client.query(query).each do |a|
    p a
  end
end
