# myapp.rb
require 'sinatra'
require_relative 'lib/code_breaker.rb'

class MyApp < Sinatra::Base
  enable :sessions
  get '/' do
    result = session[:result]&.last
    @results = session[:result]
    @guess = result[:guess] unless result.nil?
    @win = result[:win] unless result.nil?
    @attemps = result[:attemps] unless result.nil?
    erb :index
  end
  post '/' do
    play = CodeBreaker.new("7519")
    play.attemps = session[:result].last[:attemps] if session[:result]
    redirect '/' if play.attemps == 0 
    guess = play.try(params[:guess])
    win = play.win
    result = session[:result] ? session[:result] : []
    result << {
      :guess => guess,
      :attemp => params[:guess],
      :win => win,
      :attemps => play.attemps
    }
    session[:result] = result
    redirect '/'
  end
  run! if app_file == $0
end
