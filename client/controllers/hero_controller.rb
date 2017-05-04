require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/player.rb')
require_relative( '../models/hero.rb')

get( '/heroes' ) do
  @heroes = Hero.all()
  erb( :"heroes/index" )
end

get( '/heroes/:id/from/:player_id' ) do
  @hero = Hero.find( params[ 'id' ].to_i() )
  @previous_id = params[ 'player_id' ].to_i()
  erb( :"heroes/details" )
end
