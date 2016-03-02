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
    @current_building.address = ""
    @current_building.apt_no = ""
    @current_building.city = "Some Town"
    @current_building.state = "Nevada"
    @current_building.zip_code = "68046"
    @current_building.landlord_name = "Ethel"
    @current_building.building_image = "www.someimage.com"
    @current_building.move_in = ""
    @current_building.move_out = "2001-01-01"
    @current_building.locked = false
    @current_building.created_by = 1
    @current_building.updated_by = 1
    @current_building.save

    @past_building = Building.new
    @past_building.id = 2
    @past_building.address = "1414 14th"
    @past_building.apt_no = ""
    @past_building.city = "Some City"
    @past_building.state = "Nevada"
    @past_building.zip_code = "68046"
    @past_building.landlord_name = "Angela"
    @past_building.building_image = "www.someimage.com"
    @past_building.move_in = "1999-01-01"
    @past_building.move_out = "2000-01-01"
    @past_building.locked = true
    @past_building.created_by = 1
    @past_building.updated_by = 1
    @past_building.save

    @new_room = Room.new
    @new_room.id = 1
    @new_room.title = "bedroom"
    @new_room.building_id = 1
    @new_room.save

    @renter_1 = Renter.new
    @renter_1.id = 1
    @renter_1.user_id = 1
    @renter_1.building_id = 1
    @renter_1.save

    @renter_2 = Renter.new
    @renter_2.id = 2
    @renter_2.user_id = 2
    @renter_2.building_id = 1
    @renter_2.save

    @renter_3 = Renter.new
    @renter_3.id = 3
    @renter_3.user_id = 1
    @renter_3.building_id = 2
    @renter_3.save

    

  end

## BUILDING TESTS - START

  def test_find_rooms_for_building
      assert_equal([1], @current_building.find_rooms_for_building)
      assert_equal(nil, @past_building.find_rooms_for_building)
  end

  def test_create_building_check_valid_action
      assert_equal(["Please include an address.", "Please include a move-in date."], @current_building.create_building_check_valid_action)
      assert_equal([], @past_building.create_building_check_valid_action)
  end


  ## BUILDING TESTS - END

 
end
  