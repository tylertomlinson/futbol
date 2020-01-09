require './test/test_helper'
require './lib/team'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test
  def setup
    @teams_collection = TeamCollection.new("./data/teams.csv")
    @team = @teams_collection.teams_array.first
  end

  def test_it_exists
    assert_instance_of TeamCollection, @teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @teams_collection.teams_array
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Team, @team
    assert_equal "1", @team.team_id
    assert_equal "Atlanta United", @team.team_name
  end

  def test_total_number_of_teams
    assert_equal 32, @teams_collection.number_of_teams
  end

  def test_it_can_find_team_name_by_id
    assert_equal "Chicago Fire", @teams_collection.team_name_by_id(4)
  end

  def test_it_can_convert_ids_to_names
    expected = {"Atlanta United"=>0.3, "Chicago Fire"=>0.56}
    assert_equal expected, @teams_collection.id_hash_to_names({1 => 0.3, 4 => 0.56})
  end

  def test_can_get_team_info_hash
    assert_equal ({
      "team_id"=>"4",
      "franchise_id"=>"16",
      "team_name"=>"Chicago Fire",
      "abbreviation"=>"CHI",
      "link"=>"/api/v1/teams/4"}),
     @teams_collection.team_info(4)
  end
end
