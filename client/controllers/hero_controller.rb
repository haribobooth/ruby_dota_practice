require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/player.rb')
require_relative( '../models/hero.rb')

get( '/heroes' ) do
  @heroes = Hero.all()
  erb( :"heroes/index" )
end

get( '/heroes/:id' ) do
  @hero = Hero.find( params[ 'id' ].to_i() )
  erb( :"heroes/details" )
end
