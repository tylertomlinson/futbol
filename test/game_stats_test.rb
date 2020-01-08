require './test/test_helper'
require './lib/game_collection'
require './lib/game_stats'


class GameStatsTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game_stats = GameStats.new(@game_collection)
    @total_game_collection = GameCollection.new("./data/games.csv")
    @total_game_stats = GameStats.new(@total_game_collection)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @game_stats.game_collection
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal  4.31, @game_stats.average_goals_per_game
  end

  def test_it_can_calculate_average_goals
    assert_equal 4.31, @game_stats.average_goals(@game_collection.games)
  end

  def test_it_can_calculate_average_goals_by_season
    avg_goals_by_season = @game_stats.average_goals_by_season
    assert_equal 4.33, avg_goals_by_season["20132014"]
    assert_equal 3.5, avg_goals_by_season["20142015"]
    assert_equal 4.6, avg_goals_by_season["20152016"]
    assert_equal 4.75, avg_goals_by_season["20162017"]
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.38, @game_stats.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.58, @game_stats.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.04, @game_stats.percentage_ties
  end

  def test_it_can_get_the_sum_of_highest_winning_and_losing_team_score
    assert_equal 7, @game_stats.highest_total_score
  end

  def test_it_can_get_the_sum_of_lowest_winning_and_losing_team_score
    assert_equal 2, @game_stats.lowest_total_score
  end

  def test_it_can_get_biggest_blowout
    assert_equal 3, @game_stats.biggest_blowout
  end

  def test_it_can_find_away_defense_goals
    assert_equal [2,1], @game_stats.find_away_defense_goals(24)
  end

  def test_it_can_find_home_defense_goals
    assert_equal [2,2], @game_stats.find_home_defense_goals(24)
  end

  def test_it_can_find_teams
    assert_equal [24, 20, 14, 16, 5, 3, 26, 28, 19], @game_stats.teams
  end

  def test_it_can_get_defensive_averages
    assert_equal ({24=>1.75, 20=>3.0, 14=>2.17, 16=>1.5, 5=>1.6, 3=>3.0, 26=>2.4, 28=>2.2, 19=>2.67}), @game_stats.find_defensive_averages
  end

  def test_it_can_get_best_defense
    assert_equal 16, @game_stats.best_defense
  end

  def test_it_can_get_worst_defense
    assert_equal 20, @game_stats.worst_defense
  end

  def test_it_can_find_away_postseason_wins
    assert_equal 3, @game_stats.find_away_type_wins(16,"20132014", "Postseason")
  end

  def test_it_can_find_home_postseason_wins
    assert_equal 2, @game_stats.find_home_type_wins(16, "20132014", "Postseason")
  end

  def test_it_can_find_total_postseason_games
    assert_equal 6, @game_stats.games_by_season_team_and_type(16, "20132014", "Postseason")
  end

  def test_it_can_find_win_percentage_of_a_team_by_type
    assert_equal 0.83, @game_stats.find_win_percentage_by_type(16, "20132014", "Postseason")
  end

  def test_it_can_find_biggest_bust
    assert_equal 23, @total_game_stats.find_biggest_bust("20132014")
  end

  def test_it_can_find_biggest_surprise
    assert_equal 26, @total_game_stats.find_biggest_surprise("20132014")
  end
end
