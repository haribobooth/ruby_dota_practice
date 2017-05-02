class Player

  attr_reader( :name, :team )


  def initialize( player_information )
    @name = player_information['name']
    @team = player_information['team']
    @favourite_heroes = player_information['favourite_heroes']
  end

end
