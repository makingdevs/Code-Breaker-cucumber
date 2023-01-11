# myapp.rb
require 'sinatra'
require_relative 'lib/code_breaker.rb'

class MyApp < Sinatra::Base
  get '/' do
    play = CodeBreaker.new("7519")
    guess = play.try (params[:guess]) unless params[:guess].nil?
    win = play.win
    erb :index, :locals => {:guess => guess, :win => win}
  end
  run! if app_file == $0
end
