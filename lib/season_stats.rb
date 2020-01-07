class SeasonStats
  def initialize(game_collection, game_teams_collection)
    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
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
end
