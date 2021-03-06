# frozen_string_literal: true
require './database_connection_setup'
require './models/user'
require './models/space'
require './models/booking'
require './models/confirmation'
require 'sinatra/base'
require 'sinatra/flash'

class MakersBNB < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash



   
   
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
    if params[:Password] != params[:Password_confirmation]
      flash[:notice] = 'Your passwords do not match'
      redirect '/'
    else
    session[:user] = User.create(
      name: params[:name], email: params[:email], password: params[:Password])  

    redirect '/spaces'
    end 
  end 

  get '/log_in' do 
    erb :log_in
  end

  post '/log_in' do 
    session[:user] = User.authenticate(email: params[:email], password: params[:Password])
    if session[:user] == nil
      flash[:notice] = 'Your details do not match'
      redirect '/log_in'
    else 
      redirect '/spaces'
    end      
  end

  get '/log_out' do
    session.clear
    flash[:notice] = 'You have logged out'
    redirect '/log_in'
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
    @ello_ello = Confirmation.find(property_id: @space_id)
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
    Confirmation.confirm(property_id: params['property_id'], booking_date: params['date'], request_id: params['request_id'])
    redirect '/spaces'
  end

  post '/requests/deny' do
    DatabaseConnection.query("UPDATE requests SET approved = FALSE WHERE id = #{params['id']};")
    redirect '/requests'
  end

  get '/owner-history' do
    @history = Booking.find(id: @user.id) 
    erb :history
  end

  get '/user-history' do
    @user_status = "user"
    @history = Booking.find_requests(name: @user.name) 
    erb :history
  end
  
  run! if app_file == $0
  
end