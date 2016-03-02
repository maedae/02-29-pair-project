require 'test_helper'

class UserTest < Minitest::Test

  def app
    MyApp
  end

  def setup
    super
    @current_user = User.new
    @current_user.id = 1
    @current_user.name = ""
    @current_user.email = "www.test@email.com"
    @current_user.password = ""
    @current_user.save

    @other_user = User.new
    @other_user.id = 2
    @other_user.name = "bob"
    @other_user.email = ""
    @other_user.password = "password"
    @other_user.save



    @current_building = Building.new
    @current_building.id = 1
    @current_building.address = "1313 13th Street Toledo, Ohio"
    @current_building.landlord_name = "Ethel"
    @current_building.building_image = "www.someimage.com"
    @current_building.move_in = "2000-01-01"
    @current_building.move_out = "2001-01-01"
    @current_building.locked = false
    @current_building.created_by = 1
    @current_building.updated_by = 1
    @current_building.save

    @past_building = Building.new
    @past_building.id = 2
    @past_building.address = "1414 14th Street Toledo, Ohio"
    @past_building.landlord_name = "Angela"
    @past_building.building_image = "www.someimage.com"
    @past_building.move_in = "1999-01-01"
    @past_building.move_out = "2000-01-01"
    @past_building.locked = true
    @past_building.created_by = 1
    @past_building.updated_by = 1
    @past_building.save

    @renter_1 = Renter.new
    @renter_1.user_id = 1
    @renter_1.building_id = 1
    @renter_1.save

    @renter_2 = Renter.new
    @renter_2.user_id = 2
    @renter_2.building_id = 1
    @renter_2.save

    @renter_3 = Renter.new
    @renter_3.user_id = 1
    @renter_3.building_id = 2
    @renter_3.save

  end

  def test_find_user_renter_building_info
    assert_equal([1, 2], @current_user.find_user_renter_building_info)
    assert_equal([1], @other_user.find_user_renter_building_info)
  end

  def test_past_building_info_for_renter_based_on_user_id
    assert_equal([2], @current_user.past_building_info_for_renter_based_on_user_id)
    assert_equal(nil, @other_user.past_building_info_for_renter_based_on_user_id)
  end

  def test_current_building_info_for_renter_based_on_user_id
    assert_equal([1], @current_user.current_building_info_for_renter_based_on_user_id)
    assert_equal([1], @other_user.current_building_info_for_renter_based_on_user_id)
  end
end


