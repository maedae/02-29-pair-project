require 'test_helper'

class UserTest < Minitest::Test

  def app
    MyApp
  end

  def setup
    super

    @current_user = User.new
    @current_user.id = 1
    @current_user.name = "Bob"
    @current_user.email = "www.test@email.com"
    @current_user.password = "1234"
    @current_user.save


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

    

  end

end
  