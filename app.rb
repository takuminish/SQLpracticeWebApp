require 'sinatra'
require 'sinatra/reloader'
require 'mysql2'
require 'dotenv'
require 'yaml'
require 'erb'

class SQLApplication < Sinatra::Base

  Dotenv.load
  yaml_file = File.read("./database.yml")
  sql_client = Mysql2::Client.new(YAML.load(ERB.new(yaml_file).result))
 
  get '/' do
    @text = 'Welcome to Sinatra!!'
    erb :index
=begin
    query = "select * from test1"
    output = ""
    result = sql_client.query(query)
    result.each do |a|
      output =  a["text"]
    end      
    return output
=end
  end
end
