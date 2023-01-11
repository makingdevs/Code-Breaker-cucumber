# myapp.rb
require 'sinatra'
require_relative 'lib/code_breaker.rb'

class MyApp < Sinatra::Base
  enable :sessions
  get '/' do
    result = session[:result]&.last
    guess = result[:guess] unless result.nil?
    win = result[:win] unless result.nil?
    erb :index, :locals => { :guess => guess, :win => win, :results => session[:result] }
  end
  post '/' do
    play = CodeBreaker.new("7519")
    guess = play.try(params[:guess])
    win = play.win
    result = session[:result] ? session[:result] : []
    result << {:guess => guess, :attemp => params[:guess], :win => win}
    session[:result] = result
    redirect '/'
  end
  run! if app_file == $0
end
