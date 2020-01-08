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

  def test_it_can_find_results_by_opponent
    expected = {
      14=>["WIN", "WIN", "LOSS", "WIN", "WIN", "WIN"],
      19=>["WIN", "WIN", "WIN", "LOSS", "WIN", "WIN"]
    }
    assert_equal expected, @season_stats.results_by_opponents(16)
  end

  def test_it_can_report_head_to_head_results
    expected = {14=>0.83, 19=>0.83}
    assert_equal expected, @season_stats.head_to_head_ids(16)
  end

  def test_can_get_game_score_differentials
    assert_equal [1, 1, 1, 2], @season_stats.game_score_differentials(20, "LOSS")
  end

  def test_can_get_biggest_team_blowout
    assert_equal 2, @season_stats.biggest_team_blowout(24)
  end

  def test_can_get_worst_team_loss
    assert_equal 2, @season_stats.worst_loss(20)
  end

  # def test_it_can_make_season_game_teams_array
  #   assert_equal [], @game_collection.make_season_game_array("20132014")
  # end
end
