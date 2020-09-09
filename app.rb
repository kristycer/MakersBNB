# frozen_string_literal: true
require './database_connection_setup'
require './models/user'
require './models/space'

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
    session[:user] = User.create(
      name: params[:name], email: params[:email], password: params[:password])
    redirect '/spaces'
  end 

  get '/log_in' do 
    erb :log_in
  end

  post '/log_in' do 
    session[:user] = User.authenticate(email: params[:email], password: params[:password])
    redirect '/spaces'
  end

  get '/spaces' do
    if session[:search] == nil
      @spaces = Space.all
    else 
      @spaces = session[:search]
    end
    erb :spaces
  end
    
  post '/spaces/search' do
    session[:search] = Space.search(params['available-from'], params['available-to'])
    redirect '/spaces'
  end

  get '/spaces/new' do 
    erb :space_new
  end

  get '/spaces/:id/booking' do
    p "here"
    p params
    @space_id = params[:id]
    erb :booking
  end

  post '/spaces/booking' do
    redirect '/spaces'
  end

  post '/spaces/new' do
    Space.create(
      name: params['property-name'], description: params['property-description'], 
      location: params['property-location'], 
      price: params['property-price'], available_from: params['available-from'], 
      available_to: params['available-to'], owner: @user.id)
    redirect '/spaces'
  end 
  
  run! if app_file == $0
  
end