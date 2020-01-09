require './test/test_helper'
require './lib/game_collection'
require './lib/game_teams_collection'
require './lib/game_stats'
require './lib/season_stats'
require './lib/team_collection'

class SeasonStatsTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game_teams_collection = GameTeamsCollection.new("./test/fixtures/game_teams_truncated.csv")
    tc = TeamCollection.new('./data/teams.csv')

    @game_stats = GameStats.new(@game_collection)

    @season_stats = SeasonStats.new(@game_stats, @game_teams_collection, tc)

    @total_game_collection = GameCollection.new("./data/games.csv")
    @total_game_teams_collection = GameTeamsCollection.new("./data/game_teams.csv")

    @total_game_stats = GameStats.new(@total_game_collection)

    @total_season_stats = SeasonStats.new(@total_game_stats, @total_game_teams_collection, tc)
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

  def test_it_can_make_seasonal_summary
    summary = @total_season_stats.seasonal_summary(18)["20152016"][:postseason]
    assert_equal 0.36, summary[:win_percentage]
    assert_equal 25, summary[:total_goals_scored]
    assert_equal 33, summary[:total_goals_against]
    assert_equal 1.79, summary[:average_goals_scored]
    assert_equal 2.36, summary[:average_goals_against]
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

  def test_it_can_find_extremest_coaches
    assert_equal ["Peter Laviolette", "Claude Julien"], @total_season_stats.extreme_coaches("20132014")
  end
end
