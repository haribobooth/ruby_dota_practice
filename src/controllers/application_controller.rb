require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development? #auto refresh on changes

get( '/test/:firstname/:surname' ) do
  return "<h1>Welcome, #{params[:firstname]} #{params[:surname]}</h1>"
end
