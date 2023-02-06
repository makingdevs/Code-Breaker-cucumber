require 'sinatra'
require_relative 'lib/code_breaker.rb'
require 'csv'

before do 
  unless File.exist?('players_data.csv')
    CSV.open('players_data.csv', 'w') do |csv|
      csv << ['Name', 'Score']
    end
  end
end

class MyApp < Sinatra::Base
  enable :sessions
  get '/' do
    if session[:name].nil?
      erb :player_name
    else
      result = session[:result]&.last
      @results = session[:result]
      @guess = result[:guess] unless result.nil?
      @win = result[:win] unless result.nil?
      @attemps = result[:attemps] unless result.nil?
      @name = session[:name]
      erb :index
    end
  end

  post '/' do
    if session[:name].nil?
      session[:name] = params[:name]
      redirect '/'
    else
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
  end
  
  run! if app_file == $0
end
