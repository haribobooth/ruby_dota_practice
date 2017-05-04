require_relative( '../../db/sql_runner.rb' )
require_relative( './hero.rb' )

class Player

  # Allow read access to all properties
  attr_reader( :name, :team, :id )

  # Take in hash and extract values to create player
  # Only extract id if exists
  def initialize( player_details )
    @id = player_details[ 'id' ].to_i unless player_details[ 'id' ].nil?
    @name = player_details['name']
    @team = player_details['team']
  end

  # Save a player instance to the database and assign the instance an id
  def save()
    sql = "
    INSERT INTO players
    ( name, team )
    VALUES
    ( '#{@name}', '#{@team}' )
    RETURNING *;
    "
    @id = SqlRunner.run( sql )[0]['id'].to_i()
  end

  # Find a player in the database using the id and delete it
  def self.delete( id )
    sql = "
    DELETE FROM players
    WHERE
    id = #{id};
    "
    SqlRunner.run( sql )
  end

  # Find a player in the database using the id and return it
  def self.find( id )
    sql = "
    SELECT * FROM players
    WHERE
    id = #{id};
    "
    player = SqlRunner.run( sql )[0]
    return Player.new( player )
  end

  # Take a hashmap, find a player in the database using the id in that hashmap
  # then update it using the values in the rest of the hashmap
  def self.update( player_details )
    sql = "
    UPDATE players SET
    ( name, team )
    =
    ( '#{player_details['name']}', '#{player_details['team']}' )
    WHERE
    id = #{player_details['id']};
    "
    SqlRunner.run( sql )
  end

  # Select all the players in the database then map them to an array
  # then return them
  def self.all()
    sql = "
    SELECT * FROM players;
    "
    return Player.get_many( sql )
  end

  # Find all favourites from the database using the player_id, then get their
  # linked heroes, map them to an array, then return the array of heroes
  def favourite_heroes()
    sql = "
    SELECT DISTINCT h.id, h.name FROM players p
    INNER JOIN favourites f
    ON f.player_id = p.id
    INNER JOIN heroes h
    ON h.id = f.hero_id
    WHERE player_id = #{@id};
    "
    return Hero.get_many( sql )
  end

  # Create a new favourite to the database linking a player_id and a hero_id
  def self.add_favourite( player_id, hero_id )
    sql = "
    INSERT INTO favourites
    ( player_id, hero_id )
    VALUES
    ( #{player_id}, #{hero_id} );
    "
    SqlRunner.run( sql )
  end

  # Delete a favourite from the database using the player_id and hero_id
  def self.remove_favourite( player_id, hero_id )
    sql = "
    DELETE FROM favourites
    WHERE
    player_id = #{player_id} AND hero_id = #{hero_id};
    "
    SqlRunner.run( sql )
  end

  # -- Reuseable methods --
  # Run sql code which will return a PGResult with multiple items
  # and extract those items into player instances, then return the array of players
  def self.get_many( sql )
    returned_player_data = SqlRunner.run( sql )
    return returned_player_data.map{ |player| Player.new( player ) }
  end

end
