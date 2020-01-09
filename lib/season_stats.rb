require_relative 'game_collection'
require_relative 'game_teams_collection'
require_relative 'createable'

class SeasonStats
  include Createable

  def initialize(game_stats, gtc)
    @game_stats = game_stats
    @gtc = gtc
    @season_game_teams_array = nil
  end

  def corresponding_game(game_id)
    @game_stats.game_collection.games.find {|game| game.game_id == game_id }
  end

  def corresponding_game_teams(games)
    games.map do |game|
      @gtc.game_teams_array.find_all {|game_team| game.game_id ==  game_team.game_id}
    end.flatten
  end

  def game_teams_of_team(game_teams, team_id)
    game_teams.find_all {|game_team| game_team.team_id == team_id}
  end

  def results_by_opponents(team_id)
    @gtc.game_teams_by_id[team_id].reduce({}) do |acc, game_team|
      opponent_id = corresponding_game(game_team.game_id).opponent_id(team_id)
      acc[opponent_id] << game_team.result if acc[opponent_id]
      acc[opponent_id] = [game_team.result] if acc[opponent_id].nil?
      acc
    end
  end

  def head_to_head_ids(team_id)
    results_by_opponents_hash = results_by_opponents(team_id)
    results_by_opponents_hash.reduce({}) do |acc, results|
      win_count = results[1].count {|result| result == "WIN"}
      acc[results[0]] = (win_count.to_f / results_by_opponents_hash[results[0]].length).round(2)
      acc
    end
  end


  def make_season_game_array(season)
    season_game_array = @game_stats.game_collection.game_hash_from_array_by_attribute(@game_stats.game_collection.games, :season)[season]

    @season_game_teams_array = season_game_array.reduce([]) do |acc, game|
      @gtc.each {|game_team| acc << game_team if game_team.game_id == game.game_id}
      acc
    end
  end

  def seasonal_summary(team_id)
    team_games_by_season = @game_stats.game_collection.from_team(@game_stats.game_collection.game_lists_by_season, team_id)
    team_games_by_season.reduce({}) do |acc, season_games_hash|
      games_chunk = @game_stats.game_collection.separate_season_by_types(season_games_hash[1])
      acc[season_games_hash[0]] = {
        regular_season: format_seasonal_summary(games_chunk[:regular_season], team_id),
        postseason: format_seasonal_summary(games_chunk[:postseason], team_id)}
      acc
    end
  end

  def format_seasonal_summary(games, team_id)
    return zeroes_hash if games.length == 0
    game_teams = game_teams_of_team(corresponding_game_teams(games), team_id)
    {win_percentage: win_percentage(game_teams),
      total_goals_scored: @game_stats.total_team_goals(games, team_id),
      total_goals_against: @game_stats.total_opponent_goals(games, team_id),
      average_goals_scored: @game_stats.average_team_goals(games, team_id),
      average_goals_against: @game_stats.average_opponent_goals(games, team_id)}
  end

  def win_percentage(game_teams)
    (game_teams.count {|game_team| game_team.result == "WIN"}.to_f / game_teams.length).round(2)
  end

  def zeroes_hash
      {win_percentage: 0.0,
      total_goals_scored: 0,
      total_goals_against: 0,
      average_goals_scored: 0.0,
      average_goals_against: 0.0}
  end

  def game_score_differentials(team_id, result)
    games = @gtc.game_ids_by_result(team_id, result)
    games.map do |game_id|
      @game_stats.game_collection.games.find{|game| game.game_id == game_id}.difference_between_score
    end
  end

  def biggest_team_blowout(team_id)
    game_score_differentials(team_id, "WIN").max
  end

  def worst_loss(team_id)
    game_score_differentials(team_id, "LOSS").max
  end
end
