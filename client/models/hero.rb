require_relative( '../../db/sql_runner.rb' )

class Hero

  attr_reader( :name, :description )

  def initialize( hero_information )
    @name = hero_information[ 'name' ]
    @description = hero_information[ 'description' ]
  end

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

  def self.delete( id )
    sql = "DELETE FROM heroes
    WHERE
    id = #{id};
    "
    SqlRunner.run( sql )
  end

  def self.find( id )
    sql = "
    SELECT * FROM heroes
    WHERE
    id = #{id};
    "
    hero = SqlRunner( sql )[0]
    return Hero.new( hero )
  end

  # -- Reuseable methods --
  def self.get_many( sql )
    returned_hero_data = SqlRunner.run( sql )
    return returned_hero_data.map({ |hero| Hero.new( hero ) })
  end

end
