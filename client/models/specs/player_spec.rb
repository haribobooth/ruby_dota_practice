require ( 'minitest/autorun' )
require ( 'minitest/rg' )

require_relative( '../player.rb' )

class PlayerSpec < MiniTest::Test

  def setup()
    # @player = Player.new({
    #   "name" => 'Admiral Bulldog',
    #   "team" => 'Alliance',
    #   "favourite_heroes" => [
    #     "Nature's Prophet",
    #     "Magnus"
    #   ]})
    @player = Player.new({
      "name" => 'Admiral Bulldog',
      "team" => 'Alliance',
      })
    end

    def test_can_create_player()
      assert_equal( Player, @player.class() )
    end

    def test_can_get_player_name()
      assert_equal( 'Admiral Bulldog', @player.name() )
    end

    def test_can_get_player_team()
      assert_equal( 'Alliance', @player.team() )
    end

    # def test_can_get_player_favourite_heroes()
    #   assert_equal( ["Nature's Prophet", "Magnus"], @player.favourite_heroes() )
    # end

    # def test_example
    #   assert_equal(expected, actual)
    # end

  end
