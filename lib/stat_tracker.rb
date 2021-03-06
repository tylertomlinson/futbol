require_relative 'game_collection'
require_relative 'game_teams_collection'
require_relative 'game_stats'
require_relative 'game_teams_stats'
require_relative 'team_collection'
require_relative 'season_stats'

class StatTracker
  attr_reader :game_path, :game_teams_path, :teams_path

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    game_teams_path = file_paths[:game_teams]
    teams_path = file_paths[:teams]

    StatTracker.new(game_path, game_teams_path, teams_path)
  end

  def initialize(game_path, game_teams_path, teams_path)
    @game_teams_collection = GameTeamsCollection.new(game_teams_path)
    @game_collection = GameCollection.new(game_path)
    @game_teams = GameTeamsStats.new(@game_teams_collection)
    @game_stats = GameStats.new(@game_collection)
    @team_collection = TeamCollection.new(teams_path)
    @season_stats = SeasonStats.new(@game_stats, @game_teams_collection, @team_collection)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def biggest_blowout
    @game_stats.biggest_blowout
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_collection.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_teams
    @team_collection.number_of_teams
  end

  def best_offense
    @team_collection.team_name_by_id(@game_teams.best_offense)
  end

  def worst_offense
    @team_collection.team_name_by_id(@game_teams.worst_offense)
  end

  def best_defense
    @team_collection.team_name_by_id(@game_stats.best_defense)
  end

  def worst_defense
    @team_collection.team_name_by_id(@game_stats.worst_defense)
  end

  def highest_scoring_visitor
    @team_collection.team_name_by_id(@game_teams.highest_scoring_visitor)
  end

  def highest_scoring_home_team
    @team_collection.team_name_by_id(@game_teams.highest_scoring_home_team)
  end

  def lowest_scoring_visitor
    @team_collection.team_name_by_id(@game_teams.lowest_scoring_visitor)
  end

  def lowest_scoring_home_team
    @team_collection.team_name_by_id(@game_teams.lowest_scoring_home_team)
  end

  def winningest_team
    @team_collection.team_name_by_id(@game_teams.winningest_team_id)
  end

  def best_fans
    @team_collection.team_name_by_id(@game_teams.best_fans_id)
  end

  def worst_fans
    @game_teams.worst_fans_ids.map {|id| @team_collection.team_name_by_id(id)}
  end

  def head_to_head(team_id)
    @team_collection.id_hash_to_names(@season_stats.head_to_head_ids(team_id.to_i))
  end

  def most_goals_scored(team_id)
    @game_teams.most_goals_scored(team_id.to_s)
  end

  def fewest_goals_scored(team_id)
    @game_teams.fewest_goals_scored(team_id.to_s)
  end

  def average_win_percentage(team_id)
    @game_teams.average_win_percentage(team_id.to_s)
  end

  def seasonal_summary(team_id)
    @season_stats.seasonal_summary(team_id.to_i)
  end

  def biggest_team_blowout(team_id)
    @season_stats.biggest_team_blowout(team_id.to_i)
  end

  def worst_loss(team_id)
    @season_stats.worst_loss(team_id.to_i)
  end

  def team_info(team_id)
    @team_collection.team_info(team_id.to_i)
  end

  def biggest_bust(season)
    @team_collection.team_name_by_id(@game_stats.find_biggest_bust(season))
  end

  def biggest_surprise(season)
    @team_collection.team_name_by_id(@game_stats.find_biggest_surprise(season))
  end

  def winningest_coach(season)
    @season_stats.extreme_coaches(season)[1]
  end

  def worst_coach(season)
    @season_stats.extreme_coaches(season)[0]
  end
end
