require_relative "game"
require_relative "csv_loadable"

class GameCollection
  include CsvLoadable

  attr_reader :games

  def initialize(file_path)
    @games = create_games(file_path)
  end

  def create_games(file_path)
    load_from_csv(file_path, Game)
  end

  def game_lists_by_season
    @games.reduce({}) do |hash, game|
      hash[game.season] << game if hash[game.season]
      hash[game.season] = [game] if hash[game.season].nil?
      hash
    end
  end

  def from_team(hash_of_games, team_id)
    hash_of_games.reduce({}) do |acc, season_and_games|
      acc[season_and_games[0]] = season_and_games[1].find_all {|game| game.home_team_id == team_id || game.away_team_id == team_id}
      acc
    end
  end

  def count_of_games_by_season
    season_games = game_lists_by_season
    season_games.each do |key, value|
      season_games[key] = value.length
    end
    season_games
  end

  def separate_season_by_types(games)
    separated_season = {regular_season: [], postseason: []}
    games.each do |game|
      separated_season[:regular_season] << game if game.type == "Regular Season"
      separated_season[:postseason] << game if game.type == "Postseason"
    end
    separated_season
  end
end
