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

  def games_by_season
    season_games = game_lists_by_season
    season_games.each do |key, value|
      season_games[key] = value.length
    end
    season_games
  end
end
