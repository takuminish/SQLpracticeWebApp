# coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'mysql2'
require 'dotenv'
require 'yaml'
require 'erb'
require './models/problem.rb'

class SQLApplication < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/problems' do
    @result = Problem.all
    p @result
    erb :problems
  end
=begin
  get '/problems/:id' do
    @id=params[:id]
    @result = Problem.find_by(params[@id])
    
    

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
      @error = 'SQL文が間違っています。'
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
    rescue
      @error = 'SQL文が間違っています。'
    end
      
    unless validation_sql(params[:sqlquery])
      @error = "SELECT文以外は使えません。"
      erb :problem
    else
      begin
        result = sql_client.query(params[:sqlquery])
        @player_column = []
        @player_rows = []
        result.each do |row| 
          @player_column = row.keys
          @player_rows << row.values
        end
      rescue
        @error = 'SQL文が間違っています。'
      end
    end
    unless @params[:correct].nil?
      if answer_check(@answer_rows,@player_rows)
        @correct = true
        @correct_message = "正答です。"
      else
        @correct = false
        @correct_message = "誤答です。"
      end
    end
    erb :problem
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
      @error = 'SQL文が間違っています。'
    end
    erb :freesql
  end

  post '/freesql' do
    query = @params[:sqlquery]
    unless validation_sql(query)
      @error = "SELECT文以外は使えません。"
      erb :freesql

    else
      begin
        unless validation_sql(query)
          @error = "SELECT文以外は使えません。"
          return
        end
        result = sql_client.query(query)
        @column_name = []
        @rows = []
        result.each do |row| 
          @column_name = row.keys
          @rows << row.values
        end
      rescue
        @error = 'SQL文が間違っています。'
      end
    end
    erb :freesql
  end

  def validation_sql(query) 
    return false if /.*insert.*/i === query
    return false if /.*delete.*/i === query
    return false if /.*update.*/i === query
    return false if /.*create.*/i === query
    return false if /.*drop.*/i === query
    return false if /.*show.*/i === query
    return false if /.*union.*/i === query
    return true
  end

  def answer_check(correct_answer,player_answer)
     if @player_rows == @answer_rows
        return true
     end
     
     return false
  end
=end
end

