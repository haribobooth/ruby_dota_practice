require_relative( '../../db/sql_runner.rb' )

class Hero

  attr_reader( :name, :description )

  def initialize( hero_details )
    @name = hero_details[ 'name' ]
    @description = hero_details[ 'description' ]
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

  def self.all()
    sql = "
    SELECT * FROM heroes;
    "
    return Hero.get_many( sql )
  end

  # -- Reuseable methods --
  def self.get_many( sql )
    returned_hero_data = SqlRunner.run( sql )
    return returned_hero_data.map({ |hero| Hero.new( hero ) })
  end

end
