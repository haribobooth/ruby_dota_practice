require ( 'minitest/autorun' )
require ( 'minitest/rg' )

require_relative( '../hero.rb' )

class HeroSpec < MiniTest::Test

  def setup()
    @hero = Hero.new({
      'name' => "Nature's Prophet",
      'description' => "Ratting expert"
    })
  end

  def test_can_get_hero_name()

  end

    # def test_example
    #   assert_equal(expected, actual)
    # end

  end
