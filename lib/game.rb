class Game
  attr_reader :season, :away_goals, :home_goals, :home_team_id, :away_team_id, :game_id, :type

  def initialize(game_info)
    @season = game_info[:season]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_team_id = game_info[:away_team_id].to_i
    @game_id = game_info[:game_id]
    @type = game_info[:type]
  end

  def total_score
    total_score = @away_goals + @home_goals
    total_score
  end

  def difference_between_score
    difference_between_score = @away_goals - @home_goals
    difference_between_score.abs
  end

  def opponent_id(team_id)
    return home_team_id if team_id != home_team_id
    away_team_id
  end

  def opponent_goals(team_id)
    return home_goals if team_id != home_team_id
    away_goals
  end
end
