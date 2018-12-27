require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

get '/' do
  'Welcome to Sinatra!!'
end
