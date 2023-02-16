require 'sinatra'
require_relative 'lib/code_breaker.rb'
require_relative 'lib/code_table.rb'
require 'csv'
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
      @data = []
      file = File.expand_path('~/.resources/players_data.csv')
      if File.exist?(file)
        CSV.foreach(file) do |row|
          @data << row
        end
      end
      @data = @data.sort_by {|row| row[1].to_i }.reverse.first(10)
      @message = session[:message]
      session[:message] = nil
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
      guess = play.try(params[:guess])
      win = play.win
      result = session[:result] ? session[:result] : []
      unless result.none? {|r| r[:attemp] == params[:guess]}
        session[:message] =  "You already tried #{params[:guess]}, try something else"
        redirect '/'
      else
        result << {
          :guess => guess,
          :attemp => params[:guess],
          :win => win,
          :attemps => play.attemps
        }
        session[:result] = result
        if play.win 
          CodeTable.prepare_file
          CodeTable.write_data(session[:name], play.attemps + 1)
        end      
      end
      redirect '/'
    end
  end

  get '/try_again' do
  session[:result] = nil  # clear session variable
  redirect '/'
end
  
  run! if app_file == $0
end
