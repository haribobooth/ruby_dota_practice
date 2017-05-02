require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development? #auto refresh on changes

get( '/test/:firstname/:surname' ) do
  return "<h1>Welcome, #{params[:firstname]} #{params[:surname]}</h1>"
end

get( '/array/:index' ) do
  array_of_names = ['Zsolt', 'Harrison', 'John']
  return "<h1>Staff member: #{array_of_names[params[:index].to_i()]}</h1>"
end
