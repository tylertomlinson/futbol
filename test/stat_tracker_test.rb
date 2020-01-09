require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './test/fixtures/games_truncated.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './test/fixtures/game_teams_truncated.csv'

    locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_method_calls_work
    team_id = "26"
    season = "20132014"
    assert @stat_tracker.highest_total_score
    assert @stat_tracker.lowest_total_score
    assert @stat_tracker.biggest_blowout
    assert @stat_tracker.percentage_home_wins
    assert @stat_tracker.percentage_visitor_wins
    assert @stat_tracker.percentage_ties
    assert @stat_tracker.count_of_games_by_season
    assert @stat_tracker.average_goals_per_game
    assert @stat_tracker.average_goals_by_season
    assert @stat_tracker.count_of_teams
    assert @stat_tracker.best_offense
    assert @stat_tracker.worst_offense
    assert @stat_tracker.best_defense
    assert @stat_tracker.worst_defense
    assert @stat_tracker.highest_scoring_visitor
    assert @stat_tracker.lowest_scoring_visitor
    assert @stat_tracker.highest_scoring_home_team
    assert @stat_tracker.lowest_scoring_home_team
    assert @stat_tracker.winningest_team
    assert @stat_tracker.best_fans
    assert @stat_tracker.worst_fans
    assert @stat_tracker.head_to_head(team_id)
    assert @stat_tracker.most_goals_scored(team_id)
    assert @stat_tracker.fewest_goals_scored(team_id)
    assert @stat_tracker.average_win_percentage(team_id)
    assert @stat_tracker.seasonal_summary(team_id)
    assert @stat_tracker.biggest_team_blowout(team_id)
    assert @stat_tracker.worst_loss(team_id)
    assert @stat_tracker.team_info(team_id)
    assert @stat_tracker.biggest_bust(season)
    assert @stat_tracker.biggest_surprise(season)
    assert @stat_tracker.winningest_coach(season)
    assert @stat_tracker.worst_coach(season)
  end
end
