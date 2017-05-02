require_relative( '../../db/sql_runner.rb' )

class Player

  attr_reader( :name, :team, :favourite_heroes )


  def initialize( player_details )
    @name = player_details['name']
    @team = player_details['team']
    @favourite_heroes = player_details['favourite_heroes']
  end

  def save()
    sql = "
    INSERT INTO players
    ( name, team, favourite_heroes )
    VALUES
    ( '#{@name}', '#{@team}', '#{@favourite_heroes}' )
    RETURNING *;
    "
    @id = SqlRunner.run( sql )[0]['id'].to_i()
  end

  def self.delete( id )
    sql = "
    DELETE FROM players
    WHERE
    id = #{id};
    "
    SqlRunner.run( sql )
  end

  def self.find( id )
    sql = "
    SELECT * FROM players
    WHERE
    id = #{id};
    "
    player = SqlRunner( sql )[0]
    return Player.new( player )
  end

  def self.update( player_details )
    sql = "
    UPDATE players SET
    ( name, team, favourite_heroes )
    =
    ( '#{player_details['name']}', '#{player_details['team']}', '#{player_details['favourite_heroes']}' )
    WHERE
    id = #{player_details['id']};
    "
    SqlRunner.run( sql )
  end

  def self.all()
    sql = "
    SELECT * FROM players;
    "
    return Player.get_many( sql )
  end

# -- Reuseable methods --
  def self.get_many( sql )
    returned_player_data = SqlRunner.run( sql )
    return returned_player_data.map({ |player| Player.new( player ) })
  end

end
