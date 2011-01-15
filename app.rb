require 'sinatra'

set :public, File.dirname(__FILE__)

get '/' do
  send_file 'index.html'
end