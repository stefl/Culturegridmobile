$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..","gem","lib"))) # for local development

require 'rubygems'
require 'sinatra'
require "sinatra/jsonp"
require "json"
require "culturegrid"

set :public, File.dirname(__FILE__)

get '/' do
  send_file 'index.html'
end

get '/search' do
  response.headers['Cache-Control'] = "public, max-age=#{60 * 60 * 24}"
  content_type :json
  query = params[:q]
  opts = params.delete_if{|k,v| k.to_s == "q" }
  puts "query: #{query}, params: #{params.inspect}"
  jsonp CultureGrid.search(query, params)
end