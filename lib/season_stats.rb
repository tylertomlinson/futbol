require_relative 'createable'

class SeasonStats
  include Createable

  def initialize(game_collection, game_teams_collection)
    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @season_game_teams_array = nil
  end

  def results_by_opponents(team_id)
    @game_teams_collection.game_teams_by_id[team_id].reduce({}) do |acc, game_team|
      corresponding_game = @game_collection.games.find {|game| game.game_id == game_team.game_id }
      opponent = corresponding_game.opponent_id(team_id)
      acc[opponent] << game_team.result if acc[opponent]
      acc[opponent] = [game_team.result] if acc[opponent].nil?
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
    season_game_array = @game_collection.game_hash_from_array_by_attribute(@game_collection.games, :season)[season]

    @season_game_teams_array = season_game_array.reduce([]) do |acc, game|
      @game_teams_collection.each {|game_team| acc << game_team if game_team.game_id == game.game_id}
      acc
    end
  end



end
