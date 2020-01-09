require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new({
      season: "20162017",
      away_goals: 2,
      home_goals: 3,
      home_team_id: 24,
      away_team_id: 20,
      game_id: 2016030171})
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal "20162017", @game.season
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal 24, @game.home_team_id
    assert_equal 20, @game.away_team_id
    assert_equal 2016030171, @game.game_id
  end

  def test_can_get_total_score
    assert_equal 5, @game.total_score
  end

  def test_can_get_difference_between_scores
    assert_equal 1, @game.difference_between_score
  end

  def test_it_can_find_opponenent_id
    assert_equal 24, @game.opponent_id(20)
    assert_equal 20, @game.opponent_id(24)
  end

  def test_it_can_find_opponenent_goals
    assert_equal 3, @game.opponent_goals(20)
    assert_equal 2, @game.opponent_goals(24)
  end

  def test_it_can_find_team_goals
    assert_equal 2, @game.team_goals(20)
    assert_equal 3, @game.team_goals(24)
  end

end
