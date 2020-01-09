require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team= Team.new({team_id: 4, teamname: "Barcelona", franchise_id: 16, abbreviation: "CHI", link: "/api/v1/teams/4"})
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
end
