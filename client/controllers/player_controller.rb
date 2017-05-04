require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/player.rb')
require_relative( '../models/hero.rb')

# Route to GET list of players
get( '/players' ) do
  @players = Player.all()
  erb( :"players/index" )
end

# Route to GET new player form
get( '/players/new') do
  erb( :"players/new" )
end

# Route to GET particular edit player form
get( '/players/:id/edit' ) do
  @player = Player.find( params[ 'id' ].to_i() )
  erb( :"players/edit" )
end

# Route to GET particular player details
get( '/players/:id' ) do
  @player = Player.find( params[ 'id' ].to_i() )
  @heroes = Hero.all()
  @favourite_heroes = @player.favourite_heroes()
  erb( :"players/details" )
end

# Route to POST new player to player list
post('/players') do
  Player.new( params ).save()
  redirect to( '/players' )
end

# Route to DELETE particular player
post( '/players/:id/delete' ) do
  Player.delete( params[ 'id' ].to_i() )
  redirect to( '/players' )
end

# Route to PUT/PATCH (update) particular player
post( '/players/:id/update' ) do
  Player.update( params )
  redirect to( '/players/' + params[ 'id' ].to_s() )
end

# Route to POST a new favourite to link a particular player and a particular hero
post( '/players/:id/favourites' ) do
  Player.add_favourite( params[ 'id' ].to_i(), params[ 'hero_id' ].to_i() )
  redirect to( '/players/' + params[ 'id' ].to_s() )
end

# Route to DELETE all favourite links between a particular player and a particular hero
post( '/players/:id/favourites/delete' ) do
  Player.remove_favourite( params[ 'id' ].to_i(), params[ 'hero_id' ].to_i() )
  redirect to( '/players/' + params[ 'id' ].to_s() )
end
