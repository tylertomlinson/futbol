require './test/test_helper'
require './lib/game_teams_collection'
require './lib/game_teams_stats'


class GameTeamsStatsTest < Minitest::Test
  def setup
    @game_teams_collection = GameTeamsCollection.new("./test/fixtures/game_teams_truncated.csv")
    @game_teams_stats = GameTeamsStats.new(@game_teams_collection)
  end

  def test_it_exists
    assert_instance_of GameTeamsStats, @game_teams_stats
  end

  def test_it_has_attributes
    assert_instance_of GameTeamsCollection, @game_teams_stats.game_teams_collection
  end

  def test_it_can_get_total_wins_per_team
    assert_equal 0, @game_teams_stats.total_wins_per_team(18)
  end

  def test_it_can_get_a_teams_average_win_percentage
    assert_equal 0.0, @game_teams_stats.average_win_percentage(20)
  end

  def test_it_can_find_win_percentage_of_a_team
    hash = @game_teams_collection.game_teams_hash
    assert_equal 0.4, @game_teams_stats.team_win_percentage(hash, 26)
  end

  def test_it_can_find_winningest_team_id
    assert_equal 24, @game_teams_stats.winningest_team_id
  end

  def test_it_can_calculate_home_or_away_differences
    hash = @game_teams_collection.game_teams_hash
    diffs = @game_teams_stats.hoa_differences(hash)
    assert diffs.find { |key, value| value < 0 }
    assert diffs.find { |key, value| value == 0 }
  end

  def test_it_can_get_the_total_goals_by_game_team_id
    assert_equal 7, @game_teams_stats.total_goals_by_team_id(20)
  end

  def test_it_can_calculate_average_goals_by_team_id
    assert_equal 1.75, @game_teams_stats.average_goals_per_team_id(20)
  end

  def test_best_offense
    assert_equal 24, @game_teams_stats.best_offense
  end

  def test_worst_offense
    assert_equal 14, @game_teams_stats.worst_offense
  end

  def test_it_can_get_home_games_only_average
    assert_equal 2.33, @game_teams_stats.home_games_only_average[26]
  end

  def test_it_can_get_away_games_only_average
      assert_equal 2.0, @game_teams_stats.away_games_only_average[26]
  end

  def test_it_can_get_team_with_highest_average_score_for_away_games
    assert_equal 24, @game_teams_stats.highest_scoring_visitor
  end

  def test_it_can_get_team_with_lowest_average_score_for_away_games
    assert_equal 14, @game_teams_stats.lowest_scoring_visitor
  end

  def test_it_can_get_team_with_highest_average_score_for_home_games
    assert_equal 24, @game_teams_stats.highest_scoring_home_team
  end

  def test_it_can_get_team_with_lowest_average_score_for_home_games
    assert_equal 3, @game_teams_stats.lowest_scoring_home_team
  end

  def test_it_can_find_id_of_team_with_best_fans
    assert_equal 20, @game_teams_stats.best_fans_id
  end

  def test_it_can_find_teams_with_worst_fans
    expected = [20, 24, 16, 14, 3, 5, 28, 26, 19]
    assert_equal expected, @game_teams_stats.worst_fans_ids
  end

  def test_most_goals_score_by_team_in_a_single_game
    assert_equal 4, @game_teams_stats.most_goals_scored(5)
  end

  def test_fewest_goals_score_by_team_in_a_single_game
    assert_equal 2, @game_teams_stats.fewest_goals_scored(5)
  end
end
