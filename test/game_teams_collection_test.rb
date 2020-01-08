require './test/test_helper'
require './lib/game_teams_collection'
require './lib/game_teams'


class GameTeamsCollectionTest < Minitest::Test
  def setup
    @game_teams_collection = GameTeamsCollection.new("./test/fixtures/game_teams_truncated.csv")
    @game_teams = @game_teams_collection.game_teams_array.first
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_teams_collection.game_teams_array
  end

  def test_it_can_create_games_from_csv
    assert_instance_of GameTeams, @game_teams
    assert_equal "away", @game_teams.hoa
    assert_equal "LOSS", @game_teams.result
  end

  def test_it_can_store_game_teams_by_id
    var = @game_teams_collection.game_teams_hash.first
    name = var[0]
    value = var[1]
    test_hash = {name => value}
    assert_equal 9, @game_teams_collection.game_teams_hash.length
  end

  def test_it_can_get_home_games_only
    assert_equal 3, @game_teams_collection.home_games_only[26].length
  end

  def test_it_can_get_away_games_only
    assert_equal 2, @game_teams_collection.away_games_only[26].length
  end

  def test_it_can_find_the_number_of_games_by_the_game_team_id
    assert_instance_of GameTeams, @game_teams
    assert_equal 4, @game_teams_collection.games_by_team_id(20).count
    assert_equal 4, @game_teams_collection.games_by_team_id(24).count
  end

  def test_total_games_per_team
    assert_equal 6, @game_teams_collection.total_games_per_team(14)
  end

  def test_it_can_make_a_game_teams_hash
    game_teams_hash = @game_teams_collection.game_teams_hash

    assert_equal 4, game_teams_hash[20].length
    assert_equal 5, game_teams_hash[3].length
  end

  def test_can_get_a_teams_game_ids_with_wins
    expected =  ["2016030171", "2016030172", "2016030173", "2016030174"]
    assert_equal expected, @game_teams_collection.winning_game_ids(24)
  end

  def test_can_get_a_teams_game_ids_with_losses
    assert_equal [], @game_teams_collection.losing_game_ids(24)
    assert_equal ["2016030171", "2016030172", "2016030173", "2016030174"], @game_teams_collection.losing_game_ids(20)
  end
end
