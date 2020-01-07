class Team

attr_reader :team_name, :team_id

  def initialize(team)
    @team_name = team[:teamname]
    @team_id = team[:team_id]
  end
end
