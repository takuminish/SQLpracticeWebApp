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

  end

  get '/problems' do
    query = "select * from Problems"
    begin
      @result = sql_client.query(query)
    rescue
      @text = 'mysql error!'
    end
    erb :problems
  end

  get '/problems/:id' do
    query = "select * from Problems where id=?"
    begin
      @result = sql_client.prepare(query).execute(params[:id])
      @result.each do |a|
        p a
      end
      "#{@result}"
    rescue
      @text = 'mysql error!'
    end
  end
  get '/freesql' do
    query = "select * from Aqours"
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
    erb :freesql
  end

  post '/freesql' do
    query = @params[:sqlquery]
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
    erb :freesql
  end
  
end
