class SongsController < ApplicationController
use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do

    erb :'/songs/new'
  end

  post '/songs' do
    @song = Song.create(name: params["Name"])

  #  if !params["Artist Name"].empty?
      @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
  #  end

    @song.genre_ids = params[:genres]
    @song.save
#binding.pry
    flash[:message] = "Successfully created song."
    #binding.pry
    redirect  "/songs/#{@song.slug}"
  end

  get "/songs/:slug" do
    @songs = Song.find_by_slug(params["slug"])
    erb :'/songs/show'
  end
end
