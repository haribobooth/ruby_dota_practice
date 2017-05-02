class Player

  attr_reader( :name )

  def initialize( player_information )
    @name = player_information['name']
    @team = player_information['team']
    @hero = player_information['favourite_hero']
  end

end
