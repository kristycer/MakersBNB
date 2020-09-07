require 'sinatra/base'

class MakersBNB < Sinatra::Base

    get '/' do
    
      erb :index
    end 

    post '/sign_up' do
        redirect '/spaces'
    end 

    get '/spaces' do
        erb :spaces
    end 
  
    run! if app_file == $0
  
  end 