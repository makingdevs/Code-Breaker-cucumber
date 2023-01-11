# myapp.rb
require 'sinatra'
require_relative 'lib/code_breaker.rb'

get '/' do
  play = CodeBreaker.new("7519")
  guess = play.try (params[:guess])
  guess = params[:guess]
  erb :index, :locals => {:guess => guess}
end
