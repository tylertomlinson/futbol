require_relative 'game_teams_collection'

class GameTeamsStats
  attr_reader :game_teams_collection

  def initialize(game_teams_collection)
    @game_teams_collection = game_teams_collection
  end

  def total_wins_per_team(team_id)
    @game_teams_collection.game_teams_array.select {|game_team| game_team.result == "WIN" && team_id == game_team.team_id.to_i}.count
  end

  def average_win_percentage(team_id)
    total_wins_per_team(team_id.to_i) / @game_teams_collection.total_games_per_team(team_id.to_i).to_f
  end

  def total_goals_by_team_id(team_id)
    @game_teams_collection.games_by_team_id(team_id).sum {|game_team| game_team.goals.to_i}
  end

  def average_goals_per_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f / @game_teams_collection.games_by_team_id(team_id).count)
  end

  def best_offense
    @game_teams_collection.unique_team_ids.max_by {|team_id| average_goals_per_team_id(team_id)}
  end

  def most_goals_scored(team_id)
    @game_teams_collection.games_by_team_id(team_id).max_by {|game_team| game_team.goals}.goals.to_i
  end

  def fewest_goals_scored(team_id)
    @game_teams_collection.games_by_team_id(team_id).min_by {|game_team| game_team.goals}.goals.to_i
  end

  def worst_offense
    @game_teams_collection.unique_team_ids.min_by {|team_id| average_goals_per_team_id(team_id)}
  end

  def home_games_only_average
    home_only_average = {}
    @game_teams_collection.home_games_only.each do |game_id, games|
      home_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    home_only_average
  end

  def away_games_only_average
    away_only_average = {}
    @game_teams_collection.away_games_only.each do |game_id, games|
      away_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    away_only_average
  end

  def highest_scoring_home_team
    new = []
    home_games_only_average.each do |game_id, average|
      if average == home_games_only_average.values.max
      new << game_id.to_i
      end
    end
    new.first
  end

  def lowest_scoring_home_team
    new = []
    home_games_only_average.each do |game_id, average|
      if average == home_games_only_average.values.min
      new << game_id.to_i
      end
    end
    new.first
  end

  def highest_scoring_visitor
    new = []
    away_games_only_average.each do |game_id, average|
      if average == away_games_only_average.values.max
      new << game_id.to_i
      end
    end
    new.first
  end

  def lowest_scoring_visitor
    new = []
    away_games_only_average.each do |game_id, average|
      if average == away_games_only_average.values.min
      new << game_id.to_i
      end
    end
    new.first
  end

  def percentage(numerator, denominator) #to-do: make Calculatable module
    return ((numerator.to_f / denominator) * 100).round(2)
  end

  def team_win_percentage(games_hash, team, hoa = nil)
    team_games = Hash.new
    if hoa
      team_games[team] = games_hash[team].find_all { |game_team| game_team.hoa == hoa }
    else
      team_games[team] = games_hash[team]
    end
    wins = team_games[team].count { |game_team| game_team.result == "WIN" }
    percentage(wins, team_games[team].length)
  end

  def winningest_team_id
    win_percentages = Hash.new
    @game_teams_collection.game_teams_by_id.each do |key, value|
      win_percentages[key] = team_win_percentage(@game_teams_collection.game_teams_by_id, key)
    end
    win_percentages.max_by { |key, value| value }[0]
  end

  def hoa_differences(all_games)
    diffs = Hash.new{}
    all_games.each do |key, value|
      diffs[key] = team_win_percentage(all_games, key, "home") - team_win_percentage(all_games, key, "away")
    end
    diffs
  end

  def best_fans_id
    hoa_differences(@game_teams_collection.game_teams_by_id).max_by { |key, value| value }[0]
  end

  def worst_fans_ids
    hoa_diffs = hoa_differences(@game_teams_collection.game_teams_by_id)
    worst_fan_teams = hoa_diffs.find_all { |key, value| value < 0 }
    worst_fan_teams.map { |element| element[0] }
  end
end
