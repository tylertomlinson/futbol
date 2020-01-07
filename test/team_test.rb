require './test/test_helper'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @team= Team.new({team_id: 4, team_name: "Barcelona"})
  end

  def test_it_exists
    assert_instance_of Team, @team  
  end
end
