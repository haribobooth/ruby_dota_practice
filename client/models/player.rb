require_relative( '../../db/sql_runner.rb' )
require_relative( './hero.rb' )

class Player

  # attr_reader( :name, :team, :favourite_heroes )
  attr_reader( :name, :team, :id )


  def initialize( player_details )
    @id = player_details[ 'id' ].to_i unless player_details[ 'id' ].nil?
    @name = player_details['name']
    @team = player_details['team']
    # @favourite_heroes = player_details['favourite_heroes']
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
    player = SqlRunner.run( sql )[0]
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

  def favourite_heroes()
    sql = "
    SELECT heroes.id, heroes.name FROM players
    INNER JOIN favourites
    ON favourites.player_id = players.id
    INNER JOIN heroes
    ON heroes.id = favourites.hero_id
    WHERE player_id = #{@id};
    "
    return Hero.get_many( sql )
  end

# -- Reuseable methods --
  def self.get_many( sql )
    returned_player_data = SqlRunner.run( sql )
    return returned_player_data.map{ |player| Player.new( player ) }
  end

end
