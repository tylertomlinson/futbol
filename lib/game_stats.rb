class GameStats
  attr_reader :game_collection

  def initialize(game_collection)
    @game_collection = game_collection
    @teams = nil
  end

  def total_opponent_goals(array, team_id)
    @game_collection.games.sum{|game| game.opponent_goals(team_id)}
  end

  def average_goals(array)
    (total_goals = array.sum {|game| game.total_score}.to_f / array.length).round(2)
  end

  def average_goals_per_game
    average_goals(@game_collection.games)
  end

  def average_goals_by_season
    season_hash = @game_collection.game_lists_by_season
    season_hash.each do |key, value|
      season_hash[key] = average_goals(value)
    end
  end

  def percentage_home_wins
    home_wins = @game_collection.games.count do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.to_f / @game_collection.games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_collection.games.count do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.to_f / @game_collection.games.length).round(2)
  end

  def percentage_ties
    ties_count = @game_collection.games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties_count.to_f / @game_collection.games.length).round(2)
  end

  def highest_total_score
    highest_score = @game_collection.games.max_by do |game|
      game.total_score
    end.total_score
    highest_score
  end

  def lowest_total_score
    lowest_score = @game_collection.games.min_by do |game|
      game.total_score
    end.total_score
    lowest_score
  end

  def biggest_blowout
    games_difference = @game_collection.games.max_by do |game|
      game.difference_between_score
    end.difference_between_score
    games_difference
  end

  def teams
    @teams = @game_collection.games.reduce([]) do |teams,game|
      teams << game.home_team_id
      teams
    end.uniq
  end

  def find_away_defense_goals(away_team_id)
    away_defense = @game_collection.games.find_all {|game| game.away_team_id == (away_team_id)}

    away_defense.map {|game| game.home_goals}
  end

  def find_home_defense_goals(home_team_id)
    home_defense = @game_collection.games.find_all {|game| game.home_team_id == (home_team_id)}

    home_defense.map {|game| game.away_goals}
  end

  def find_average_defense_goals(team_id)
    defense_goals_array = find_home_defense_goals(team_id) + find_away_defense_goals(team_id)

    goals_total = defense_goals_array.reduce(0) {|sum, defense_score| sum + defense_score}

    average = (goals_total.to_f / defense_goals_array.length).round(2)
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

  def find_away_type_wins(away_team_id, season, type)
    away_games = @game_collection.game_lists_by_season[season].find_all {|game| game.away_team_id == away_team_id && game.type == type && game.season == season}

    away_games.find_all {|game| game.away_goals > game.home_goals}.length
  end

  def find_home_type_wins(home_team_id, season, type)
    home_games = @game_collection.game_lists_by_season[season].find_all {|game| game.home_team_id == home_team_id && game.type == type && game.season == season}

    home_games.find_all {|game| game.home_goals > game.away_goals}.length
  end

  def games_by_season_team_and_type(team_id, season, type)
    away_games = @game_collection.game_lists_by_season[season].find_all {|game| game.type == type && game.away_team_id == team_id}.length
    home_games = @game_collection.game_lists_by_season[season].find_all {|game| game.type == type && game.home_team_id == team_id}.length

    away_games + home_games
  end

  def find_win_percentage_by_type(team_id, season, type)
    return 0.0 if games_by_season_team_and_type(team_id, season, type).to_f == 0.0
    ((find_away_type_wins(team_id, season, type) + find_home_type_wins(team_id, season, type)) / games_by_season_team_and_type(team_id, season, type).to_f).round(2)
  end

  def find_difference_in_win_percentage_by_type(team_id, season)
    find_win_percentage_by_type(team_id, season, "Regular Season") - find_win_percentage_by_type(team_id, season, "Postseason")
  end

  def make_teams_by_win_percentage_difference(season)
    teams

    all_teams = @teams.reduce({}) do |acc, team|
      acc[team] = find_difference_in_win_percentage_by_type(team, season)
      acc
    end

    all_teams.each do |team_id, difference|
      all_teams[team_id] = 0.0 if difference.nan? == true
    end
    all_teams
  end

  def find_biggest_bust(season)
    make_teams_by_win_percentage_difference(season).max_by {|team_id, difference| difference}[0]
  end

  def find_biggest_surprise(season)
    make_teams_by_win_percentage_difference(season).min_by {|team_id, difference| difference}[0]
  end
end
