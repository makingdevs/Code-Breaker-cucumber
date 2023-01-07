# myapp.rb
require 'sinatra'
require_relative 'lib/code_breaker.rb'

get '/' do
 erb :index
end
post '/' do
    play = CodeBreaker.new("7519")
    guess = play.try (params[:guess])
    " your try was , #{guess}!"
  end
  