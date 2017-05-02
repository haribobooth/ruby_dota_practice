class Hero

  attr_reader( :name )

  def initialize( hero_information )
    @name = hero_information[ 'name' ]
    @description = hero_information[ 'description' ]
  end

end
