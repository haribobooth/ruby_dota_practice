require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( '../models/player.rb')
require_relative( '../models/hero.rb')

# Route to GET list of heroes
get( '/heroes' ) do
  @heroes = Hero.all()
  erb( :"heroes/index" )
end

# Route to GET particular hero details
get( '/heroes/:id/from/:player_id' ) do
  @hero = Hero.find( params[ 'id' ].to_i() )

  # Takes in where the user had navigated to here from to make back button
  previous_id = params[ 'player_id' ].to_i()
  if(previous_id != 0)
    @previous_url = '/players/' + previous_id.to_s()
  else
    @previous_url = '/heroes'
  end

  erb( :"heroes/details" )
end
