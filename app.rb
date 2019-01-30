# coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'mysql2'
require 'dotenv'
require 'yaml'
require 'erb'
require './models/problem.rb'
require './models/book.rb'

class SQLApplication < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/problems' do
    @result = Problem.all
    @columns = Problem.columns
    erb :problems
  end

  get '/problems/:id' do
    @id = params[:id]
    @problem = Problem.find_by(params[@id])

    @answer_column = []
    Problem.columns.each do |col|
      @answer_column << col.name
    end

    answer = ActiveRecord::Base.connection.select_all(@problem["answer"]).to_hash
      @answer_column = []
      @answer_rows = []
      answer.each do |row| 
        @answer_column = row.keys
        @answer_rows << row.values
      end
     
    erb :problem
    
  end

  post '/problems/:id' do
        @id = params[:id]
    @problem = Problem.find_by(params[@id])

    @answer_column = []
    Problem.columns.each do |col|
      @answer_column << col.name
    end

    answer = ActiveRecord::Base.connection.select_all(@problem["answer"]).to_hash
      @answer_column = []
      @answer_rows = []
      answer.each do |row| 
        @answer_column = row.keys
        @answer_rows << row.values
      end
          
    unless validation_sql(params[:sqlquery])
      @error = "SELECT文以外は使えません。"
      erb :problem
    else
      result = ActiveRecord::Base.connection.select_all(params[:sqlquery]).to_hash
      @player_column = []
      @player_rows = []

      result.each do |row| 
        @player_column = row.keys
        @player_rows << row.values
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
    result = ActiveRecord::Base.connection.select_all("select * from books").to_hash

    @column_name = []
    @rows = []
    result.each do |row| 
      @column_name = row.keys
      @rows << row.values
    end

    erb :freesql
  end

  post '/freesql' do
    query = @params[:sqlquery]
    unless validation_sql(query)
      @error = "SELECT文以外は使えません。"
      erb :freesql

    else
      unless validation_sql(query)
        @error = "SELECT文以外は使えません。"
         erb :freesql
        return
      end
      result = ActiveRecord::Base.connection.select_all("select * from books").to_hash
      @column_name = []
      @rows = []
      result.each do |row| 
        @column_name = row.keys
        @rows << row.values
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

end

