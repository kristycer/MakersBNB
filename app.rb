# frozen_string_literal: true
require './database_connection_setup'
require './models/user'

require 'sinatra/base'

class MakersBNB < Sinatra::Base
  enable :sessions  
  
    before do
      @user = session[:user]
    end  

    get '/' do
      erb :index
    end 

    post '/sign_up' do
      session[:user] = User.create(name: params[:name], email: params[:email], password: params[:password])
      redirect '/spaces'
    end 

    get '/log_in' do 
      erb :log_in
    end

    post '/log_in' do 
      session[:user] =  User.authenticate(email: params[:email], password: params[:password])
      redirect '/spaces'
    end

    get '/spaces' do
      erb :spaces
    end 

    get '/spaces/new' do 
      erb :space_new
    end

  
  run! if app_file == $0
  
end
