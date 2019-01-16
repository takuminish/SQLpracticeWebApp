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
    query = "select id,name from Aqours"
    begin
      result = sql_client.query(query)
      @column_name = []
      @rows = []
      result.each do |row| 
        @column_name = row.keys
        @rows << row.values
      end
    rescue
      @text = 'mysql error!'
    end
    erb :index
  end

  get '/freesql' do
    @text = 'freesql'
    erb :freesql
  end
end
