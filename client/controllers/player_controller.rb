require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/player.rb')
require_relative( '../models/hero.rb')

get( '/players' ) do
  @players = Player.all()
  erb( :"players/index" )
end

get( '/players/:id' ) do
  @player = Player.find( params[ 'id' ].to_i() )
  @favourite_heroes = @player.favourite_heroes()
  erb( :"players/details" )
end
