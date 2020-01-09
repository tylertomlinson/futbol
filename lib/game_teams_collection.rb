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
    teams_by_hoa("home")
  end

  def away_games_only
    teams_by_hoa("away")
  end

  def teams_by_hoa(hoa)
    @game_teams_by_id.reduce({}) do |acc, game_teams|
      acc[game_teams[0]] = game_teams[1].find_all {|gt| gt.hoa == hoa}
      acc
    end
  end

  def game_ids_by_result(team_id, result)
    @game_teams_by_id[team_id].map do |game_team|
        game_team.game_id if game_team.result == result
    end.compact
  end

  def game_teams_by_coach
    @game_teams_array.reduce({}) do |acc, game_team|
      acc[game_team.head_coach] << game_team if acc[game_team.head_coach]
      acc[game_team.head_coach] = [game_team] if acc[game_team.head_coach].nil?
      acc
    end
  end
end
