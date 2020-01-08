require './test/test_helper'
require './lib/game_collection'
require './lib/game'

class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game = @game_collection.games.first
    @total_game_collection = GameCollection.new("./data/games.csv")
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_collection.games
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Game, @game
    assert_equal "20162017", @game.season
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_it_can_store_games_by_season
    assert_equal 4, @game_collection.game_lists_by_season.length
  end

  def test_games_by_season
    expected = {"20162017" => 4, "20142015" => 6, "20152016" => 10, "20132014" => 6}
    assert_equal expected, @game_collection.games_by_season
  end
end
