require_relative "game_teams"
require_relative 'csv_loadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams_array, :game_teams_by_id

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
    @game_teams_by_id = game_teams_hash
  end

  def create_game_teams_array(file_path)
    load_from_csv(file_path, GameTeams)
  end

  def games_by_team_id(team_id)
    @game_teams_array.select {|game_team| game_team.team_id == team_id.to_i}
  end

  def total_games_per_team(team_id)
    games_by_team_id(team_id.to_i).length
  end

  def unique_team_ids
    @game_teams_array.uniq {|game_team| game_team.team_id}.map { |game_team| game_team.team_id}
  end

  def game_teams_hash
    @game_teams_array.reduce({}) do |hash, game_teams|
      hash[game_teams.team_id] << game_teams if hash[game_teams.team_id]
      hash[game_teams.team_id] = [game_teams] if hash[game_teams.team_id].nil?
      hash
    end
  end

  def home_games_only
    home_only = {}
    @game_teams_by_id.each do |team_id, games|
      home_only[team_id] = games.find_all do |game|
        game.hoa == "home"
      end
    end
    home_only
  end

  def away_games_only
    away_only = {}
    @game_teams_by_id.each do |team_id, games|
      away_only[team_id] = games.find_all do |game|
        game.hoa == "away"
      end
    end
    away_only
  end

  def winning_game_ids(team_id)
    game_ids = []
    @game_teams_array.each do |game_team|
      if game_team.result == "WIN" && game_team.team_id == team_id
        game_ids << game_team.game_id
      end
    end
    game_ids
  end
end
