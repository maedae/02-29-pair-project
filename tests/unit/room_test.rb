require 'test_helper'

class RoomTest < Minitest::Test

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
    @new_room.room_image = "fgjkhfdgkjfdg/skgjfdhgkdjg"
    @new_room.location = "Indoor"
    @new_room.created_by = @current_user.id
    @new_room.updated_by = @other_user.id
    @new_room.save

    @other_room = Room.new
    @other_room.title = ""
    @other_room.building_id = @past_building.id
    @other_room.room_image = ""
    @other_room.location = nil
    @other_room.created_by = @current_user.id
    @other_room.updated_by = nil
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
    @photo_1.image = "yiwer"
    @photo_1.save

    @photo_3 = Photo.new
    @photo_3.item_id = @new_item.id
    @photo_3.image = "gvfujs"
    @photo_3.save

    @photo_2 = Photo.new
    @photo_2.item_id = @other_item.id
    @photo_2.image = "ubeablu"
    @photo_2.save


   
end

## ROOM TESTS - START

  def test_find_damaged_items_for_room
    assert_equal([@new_item], @new_room.find_damaged_items_for_room)
    refute_equal([@historic_item], @new_room.find_damaged_items_for_room)
  end

  def test_find_good_items_for_room
    assert_equal([@historic_item], @new_room.find_good_items_for_room)
    refute_equal([@new_item], @new_room.find_good_items_for_room)
  end

  def test_find_and_delete_items_for_room
    @new_room.find_and_delete_items_for_room
    assert_equal([], Item.where({"room_id" => @new_room.id}))
    refute_equal([@other_item], Item.where({"room_id" => @new_room.id}))
  end

  def test_find_created_by_user_info_for_room
    assert_equal(@current_user, @new_room.find_created_by_user_info_for_room)
  end

  def test_find_updated_by_user_info_for_room
    assert_equal(@other_user, @new_room.find_updated_by_user_info_for_room)
  end

  def test_room_error_check
    assert_equal([], @new_room.room_error_check)
    assert_equal(["Please include a room type.", "Please set the location of your room."], @other_room.room_error_check)
  end
  ## ROOM TESTS - END

 
end
