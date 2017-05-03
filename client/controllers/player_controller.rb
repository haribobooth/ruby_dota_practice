require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/player.rb')
require_relative( '../models/hero.rb')

get( '/players' ) do
  @players = Player.all()
  erb( :"players/index" )
end

get( '/players/new') do
  erb( :"players/new" )
end

get( '/players/:id/edit' ) do
  @player = Player.find( params[ 'id' ].to_i() )
  erb( :"players/edit" )
end

get( '/players/:id' ) do
  @player = Player.find( params[ 'id' ].to_i() )
  @heroes = Hero.all()
  @favourite_heroes = @player.favourite_heroes()
  erb( :"players/details" )
end

post('/players') do
  Player.new( params ).save()
  redirect to( '/players' )
end

post( '/players/:id/delete' ) do
  Player.delete( params[ 'id' ].to_i() )
  redirect to( '/players' )
end

post( '/players/:id/update' ) do
  Player.update( params )
  redirect to( '/players/' + params[ 'id' ].to_s() )
end

post( '/players/:id/favourites' ) do
  Player.add_favourite( params[ 'id' ].to_i(), params[ 'hero_id' ].to_i() )
  redirect to( '/players/' + params[ 'id' ].to_s() )
end

post( '/players/:id/favourites/delete' ) do
  Player.remove_favourite( params[ 'id' ].to_i(), params[ 'hero_id' ].to_i() )
  redirect to( '/players/' + params[ 'id' ].to_s() )
end
