require_relative( '../../db/sql_runner.rb' )

class Player

  attr_reader( :name, :team, :favourite_heroes )


  def initialize( player_information )
    @name = player_information['name']
    @team = player_information['team']
    @favourite_heroes = player_information['favourite_heroes']
  end

  def save()
    sql = "
    INSERT INTO players
    ( name, team, favourites_heroes )
    VALUES
    ( '#{@name}', '#{@team}', '#{@favourites_heroes}' )
    RETURNING *;
    "
    @id = SqlRunner.run( sql )[0]['id'].to_i()
  end

  def self.delete( id )
    sql = "
    DELETE FROM players
    WHERE
    id = #{id;}
    "
    SqlRunner.run( sql )
  end

  def self.find( id )
    sql = "
    SELECT * FROM players
    WHERE
    id = #{id}
    "
    player = SqlRunner( sql )[0]
    return Player.new( player )
  end

  def self.update( details )

  end

  def self.all()

  end

# -- Reuseable methods --
  def self.get_many( sql )
    returned_player_data = SqlRunner.run( sql )
    return returned_player_data.map({ |player| Player.new( player ) })
  end

end
