# frozen_string_literal: true
require './database_connection_setup'
require './models/user'
require './models/space'
require './models/booking'
require 'sinatra/base'

class MakersBNB < Sinatra::Base
  enable :sessions

  helpers do
    def current_space
      @current_space ||= Space.find(id: session[:space_id])
    end
  end
  
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
    session[:owner_id] = params[:owner_id]
    @space_id = params[:id]
    erb :booking
  end

  post '/spaces/:id/booking' do
    session[:space_id] = params[:id]
    Booking.create(property_name: current_space.name, booking_date: params['date'], total_price: current_space.price, name: @user.name, email: @user.email, owner_id: session[:owner_id], property_id: current_space.id)
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

  get '/requests' do
    @requests = Booking.find(id: @user.id) 
    erb :requests
  end

  post '/requests/confirm' do
    p params
    redirect '/spaces'
  end
  
  run! if app_file == $0
  
end