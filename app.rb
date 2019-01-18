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
    erb :index
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
    @id=params[:id]
    begin
      @result = sql_client.prepare(query).execute(params[:id])
      @result.each do |a|
        @problem = a
      end
      answer = sql_client.query(@problem["answer"])
      @answer_column = []
      @answer_rows = []
      answer.each do |row| 
        @answer_column = row.keys
        @answer_rows << row.values
      end

    rescue
      @text = 'mysql error!'
    end

    erb :problem
    
  end

  post '/problems/:id' do
    @id = params[:id]
    begin
      query = "select * from Problems where id=?"
      @result = sql_client.prepare(query).execute(params[:id])
      @result.each do |a|
        @problem = a
      end
      answer = sql_client.query(@problem["answer"])
      @answer_column = []
      @answer_rows = []
      answer.each do |row| 
        @answer_column = row.keys
        @answer_rows << row.values
      end
      result = sql_client.query(params["sqlquery"])
      @player_column = []
      @player_rows = []
      result.each do |row| 
        @player_column = row.keys
        @player_rows << row.values
      end
    rescue
      @text = 'mysql error!'
    end
     
    erb :problem
  end
  get '/freesql' do
    query = "select * from Aqours"
    begin
      @result = sql_client.query(query)
      @column_name = []
      @prows = []
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
