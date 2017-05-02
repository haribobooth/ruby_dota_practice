require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?

require_relative( './controllers/player_controller.rb' )
require_relative( './controllers/hero_controller.rb')

get( '/' ) do
  erb(:index)
end
