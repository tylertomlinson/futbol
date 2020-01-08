require_relative 'team'
require_relative 'csv_loadable'

class TeamCollection
  include CsvLoadable

  attr_reader :teams_array

  def initialize(file_path)
    @teams_array = create_teams_array(file_path)
  end

  def create_teams_array(file_path)
    load_from_csv(file_path, Team)
  end

  def number_of_teams
    @teams_array.length
  end

  def team_name_by_id(team_id)
    @teams_array.find {|team| team.team_id.to_i == team_id}.team_name
  end

  def team_info(team_id)
    team = @teams_array.find {|team| team.team_id.to_i == team_id}
    {
      "team_id" => team.team_id,
      "franchise_id" => team.franchise_id,
      "team_name" => team.team_name,
      "abbreviation" => team.abbreviation,
      "link" => team.link
    }
  end
end
