class Player

  attr_reader( :name, :team, :favourite_heroes )


  def initialize( player_information )
    @name = player_information['name']
    @team = player_information['team']
    @favourite_heroes = player_information['favourite_heroes']
  end

end
