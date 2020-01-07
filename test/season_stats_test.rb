require './test/test_helper'
require './lib/game_collection'
require './lib/game_teams_collection'
require './lib/season_stats'

class SeasonStatsTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game_teams_collection = GameTeamsCollection.new("./test/fixtures/game_teams_truncated.csv")
    @season_stats = SeasonStats.new(@game_collection, @game_teams_collection)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end
end
