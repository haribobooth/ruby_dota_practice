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

  # -- Reuseable methods --
  def self.get_many( sql )
    returned_hero_data = SqlRunner.run( sql )
    return returned_hero_data.map({ |hero| Hero.new( hero ) })
  end

end
