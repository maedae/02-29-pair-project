require 'test_helper'

class ItemTest < Minitest::Test

  def app
    MyApp
  end

  def setup
    super

    @current_user = User.new
    @current_user.name = ""
    @current_user.email = "www.test@email.com"
    @current_user.password = ""
    @current_user.save

    @other_user = User.new
    @other_user.name = "bob"
    @other_user.email = ""
    @other_user.password = "password"
    @other_user.save

    @current_building = Building.new
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
    @current_building.created_by = @current_user.id
    @current_building.updated_by = @current_user.id
    @current_building.save

    @past_building = Building.new
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
    @past_building.created_by = @other_user.id
    @past_building.updated_by = @other_user.id
    @past_building.save

    @new_room = Room.new
    @new_room.title = "bedroom"
    @new_room.building_id = @current_building.id
    @new_room.save

    @other_room = Room.new
    @other_room.title = ""
    @other_room.building_id = @past_building.id
    @other_room.save


    @new_item = Item.new
    @new_item.title = "broken window"
    @new_item.room_id = @new_room.id
    @new_item.description = "Window sucks"
    @new_item.condition = 2
    @new_item.created_by = @current_user.id
    @new_item.updated_by = @current_user.id 
    @new_item.save

    @historic_item = Item.new
    @historic_item.title = ""
    @historic_item.room_id = @new_room.id
    @historic_item.description = ""
    @historic_item.condition = 5
    @historic_item.created_by = @current_user.id
    @historic_item.updated_by = @current_user.id
    @historic_item.save

    @other_item = Item.new
    @other_item.title = "broken cat"
    @other_item.room_id = @other_room.id
    @other_item.description = ""
    @other_item.condition = nil
    @other_item.created_by = @current_user.id
    @other_item.updated_by = @current_user.id
    @other_item.save


    @renter_1 = Renter.new
    @renter_1.user_id = @current_user.id
    @renter_1.building_id = @current_building.id
    @renter_1.save

    @renter_2 = Renter.new
    @renter_2.user_id = @other_user.id
    @renter_2.building_id = @current_building.id
    @renter_2.save

    @renter_3 = Renter.new
    @renter_3.user_id = @current_user.id
    @renter_3.building_id = @past_building.id
    @renter_3.save

    @photo_1 = Photo.new
    @photo_1.item_id = @new_item.id
    @photo_1.image = "iyvsrlubeablu"

    @photo_2 = Photo.new
    @photo_2.item_id = @other_item.id
    @photo_2.image = "iyvsrlubeablu"



   
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
