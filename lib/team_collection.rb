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

  def id_hash_to_names(id_hash)
    id_hash.reduce({}) do |acc, value_hash|
      acc[team_name_by_id(value_hash[0])] = value_hash[1]
      acc
    end
  end
end
