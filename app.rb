# frozen_string_literal: true

require 'sinatra/base'

class MakersBNB < Sinatra::Base


    get '/' do
    
      erb :index
    end 

    post '/sign_up' do
        redirect '/spaces'
    end 

    get '/log_in' do 
      erb :log_in
    end

    post '/log_in' do 
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
