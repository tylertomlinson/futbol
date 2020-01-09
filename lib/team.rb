class Team
attr_reader :team_name, :team_id, :franchise_id, :abbreviation, :link

  def initialize(team)
    @team_name = team[:teamname]
    @team_id = team[:team_id]
    @franchise_id = team[:franchiseid]
    @abbreviation = team[:abbreviation]
    @link = team[:link]
  end
end
