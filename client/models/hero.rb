require_relative( '../../db/sql_runner.rb' )

class Hero

  # Allow read access to all properties
  attr_reader( :name, :description, :id )

  # Take in hash and extract values to create hero
  # Only extract id if exists
  def initialize( hero_details )
    @id = hero_details[ 'id' ].to_i unless hero_details[ 'id' ].nil?
    @name = hero_details[ 'name' ]
    @description = hero_details[ 'description' ]
  end

  # Save a hero instance to the database and assign the instance an id
  def save()
    sql = "
    INSERT INTO heroes
    ( name, description )
    VALUES
    ( '#{@name}', '#{@description}' )
    RETURNING *;
    "

    @id = SqlRunner.run( sql )[0]['id'].to_i()
  end

  # Find a hero in the database using the id and delete it
  def self.delete( id )
    sql = "DELETE FROM heroes
    WHERE
    id = #{id};
    "
    SqlRunner.run( sql )
  end

  # Find a hero in the database using the id and return it
  def self.find( id )
    sql = "
    SELECT * FROM heroes
    WHERE
    id = #{id};
    "
    hero = SqlRunner.run( sql )[0]
    return Hero.new( hero )
  end

  # Take a hashmap, find a hero in the database using the id in that hashmap
  # then update it using the values in the rest of the hashmap
  def self.update( hero_details )
    sql = "
    UPDATE heroes SET
    ( name, description )
    =
    ( '#{hero_details['name']}', '#{hero_details['description']}' )
    WHERE
    id = #{hero_details['id']};
    "
    SqlRunner.run( sql )
  end

  # Select all the heroes in the database then map them to an array
  # then return them
  def self.all()
    sql = "
    SELECT * FROM heroes;
    "
    return Hero.get_many( sql )
  end

  # -- Reuseable methods --
  # Run sql code which will return a PGResult with multiple items
  # and extract those items into hero instances, then return the array of heroes
  def self.get_many( sql )
    returned_hero_data = SqlRunner.run( sql )
    return returned_hero_data.map{ |hero| Hero.new( hero ) }
  end

end
