require_relative "game"
require_relative "csv_loadable"
require_relative "createable"

class GameCollection
  include CsvLoadable
  include Createable

  attr_reader :games

  def initialize(file_path)
    @games = create_games(file_path)
    @teams = nil
  end

  def create_games(file_path)
    load_from_csv(file_path, Game)
  end

  def average_goals(array)
    total_goals = array.reduce(0) do |sum, game|
      sum += game.total_score
      sum
    end
    (total_goals.to_f / array.length).round(2)
  end

  def average_goals_per_game
    average_goals(@games)
  end

  def average_goals_by_season
    season_hash = game_lists_by_season
    season_hash.each do |key, value|
      season_hash[key] = average_goals(value)
    end
  end

  def game_lists_by_season
    @games.reduce({}) do |hash, game|
      hash[game.season] << game if hash[game.season]
      hash[game.season] = [game] if hash[game.season].nil?
      hash
    end
  end

  # def game_hash_from_array_by_attribute(array, attribute)
  #   array.reduce({}) do |hash, array_object|
  #     hash[array_object.send(attribute)] = [array_object] if hash[array_object.send(attribute)].nil?
  #     hash[array_object.send(attribute)] << array_object if hash[array_object.send(attribute)]
	# 		hash
	# 	end
  # end
  #
  # def game_hash_from_hash_by_attribute(hash, key, attribute)
  #   hash[key].reduce({}) do |hash, array_object|
  #     hash[array_object.send(attribute)] = [array_object] if hash[array_object.send(attribute)].nil?
  #     hash[array_object.send(attribute)] << array_object if hash[array_object.send(attribute)]
	# 		hash
	# 	end
  # end

  def games_by_season
    season_games = game_lists_by_season
    season_games.each do |key, value|
      season_games[key] = value.length
    end
    season_games
  end

  #could possibly move to game_teams_collection?
  def percentage_home_wins
    home_wins = @games.count do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.to_f / @games.length).round(2)
  end

  #could possibly move to game_teams_collection?
  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.to_f / @games.length).round(2)
  end

  #could possibly move to game_teams_collection?
  def percentage_ties
    ties_count = @games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties_count.to_f / @games.length).round(2)
  end

  def highest_total_score
    highest_score = @games.max_by do |game|
      game.total_score
    end.total_score
    highest_score
  end

  def lowest_total_score
    lowest_score = @games.min_by do |game|
      game.total_score
    end.total_score
    lowest_score
  end

  def biggest_blowout
    games_difference = @games.max_by do |game|
      game.difference_between_score
    end.difference_between_score
    games_difference
  end

  def find_away_defense_goals(away_team_id)
    away_defense = @games.find_all {|game| game.away_team_id == (away_team_id)}

    away_defense.map {|game| game.home_goals}
  end

  def find_home_defense_goals(home_team_id)
    home_defense = @games.find_all {|game| game.home_team_id == (home_team_id)}

    home_defense.map {|game| game.away_goals}
  end

  def find_average_defense_goals(team_id)
    defense_goals_array = find_home_defense_goals(team_id) + find_away_defense_goals(team_id)

    goals_total = defense_goals_array.reduce(0) {|sum, defense_score| sum + defense_score}

    average = (goals_total.to_f / defense_goals_array.length).round(2)
  end

  def teams
    @teams = @games.reduce([]) do |teams,game|
      teams << game.home_team_id
      teams
    end.uniq
  end

  def find_defensive_averages
    teams.reduce({}) do |defenses, team|
      defenses[team] = find_average_defense_goals(team)
      defenses
    end
  end

  def worst_defense
    find_defensive_averages.max_by{|team, average| average}[0]
  end

  def best_defense
    find_defensive_averages.min_by{|team, average| average}[0]
  end

  def make_team_ids

  end

  def find_away_type_wins(away_team_id, season, type)
    away_games = game_lists_by_season[season].find_all {|game| game.away_team_id == away_team_id && game.type == type && game.season == season}
    # require "pry"; binding.pry
	  away_games.find_all {|game| game.away_goals > game.home_goals}.length
  end

  def find_home_type_wins(home_team_id, season, type)
    home_games = game_lists_by_season[season].find_all {|game| game.home_team_id == home_team_id && game.type == type && game.season == season}
    # require "pry"; binding.pry
	  home_games.find_all {|game| game.home_goals > game.away_goals}.length
  end

  def games_by_season_team_and_type(team_id, season, type)
    away_games = game_lists_by_season[season].find_all {|game| game.type == type && game.away_team_id == team_id}.length

    home_games = game_lists_by_season[season].find_all {|game| game.type == type && game.home_team_id == team_id}.length

    away_games + home_games
  end

  def find_win_percentage_by_type(team_id, season, type)
    ((find_away_type_wins(team_id, season, type) + find_home_type_wins(team_id, season, type)) / games_by_season_team_and_type(team_id, season, type).to_f).round(2)
  end

  def find_difference_in_win_percentage_by_type(team_id, season)
    find_win_percentage_by_type(team_id, season, "Regular Season") - find_win_percentage_by_type(team_id, season, "Postseason")
  end

  def make_teams_by_win_percentage_difference(season)
    teams

    @teams.reduce({}) do |acc, team|
      acc[team] = find_difference_in_win_percentage_by_type(team, season)
      acc
    end

  end

  def find_biggest_bust(season)

  end

  def find_biggest_suprise(season)

  end
end
