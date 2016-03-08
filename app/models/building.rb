# Class is the handles instances of Building Object created by the User, 
# Each building can belong to multiple Renter Instances. Each building can have multiple Room instances.
class Building < ActiveRecord::Base

  mount_uploader :building_image, MainUploader
  
  # Method finds all associated Rooms for a Building,
  # and puts each into an Array.
  #
  # Returns an Array of Room IDs(@arr_rooms)
  # If the Array is empty, method RETURNS nil
  def find_rooms_for_building
    return Room.where({"building_id" => self.id})
  end

  def find_room_id_array_for_room
    return Room.where({"building_id" => self.id}).pluck(:id)
  end

  # Method Passes in building instance ID and user ID. Searches for the renter with those perimeters and deletes the renter.
  def delete_renter_when_deleting_building(user_id)
    Renter.where({"user_id" => user_id, "building_id" => self.id}).delete_all
  end
  
  # Method searches for Renters by their Building IDs
  #
  # If there are no renters found, the building is deleted. 
  # RETURNS nil
  def check_if_building_has_other_renters
      renters = Renter.exists?(:building_id => self.id)
      if renters == false
        self.delete
      end
  end

  def get_created_by_user_info
    return User.find_by_id(self.created_by)
  end

  def get_updated_by_user_info
    return self.updated_by != nil ?  User.find_by_id(self.updated_by) : nil
  end

  # Method conducts validation on input from form fields
  # by calling other methods
  #
  # Initializes an Array (message), and puts a message specific to an error
  # into it when the validation fails.
  # Method RETURNS an Array (message).
  def create_building_check_valid_action
    @error = []
    find_create_and_update_address_errors
    find_create_and_update_moving_date_errors
    return @error
  end

  def find_create_and_update_address_errors
    check_create_building_address_is_valid
    check_create_building_city_is_valid
    check_create_building_state_is_valid
    check_create_building_zip_code_is_valid
  end

  def find_create_and_update_moving_date_errors
    check_create_building_move_in_is_valid
    check_create_building_move_out_is_valid
  end

  # ____________________________________________________
  #
  # Methods below check each chunk of form data to validate their contents.
  # If the form data passes or fails,  
  #
  # Each RETURNS a corresponding Boolean value
  def check_create_building_address_is_valid
    address = self.address != "" ? true : false
    if address == false
      @error << "Please include an address."
    end
  end
  
  # RETURNS a Boolean
  def check_create_building_city_is_valid
    city = self.city != "" ? true : false
    if city == false
      @error << "Please include a city."
    end
  end

  # RETURNS a Boolean
  def check_create_building_state_is_valid
    state = self.state != "" ? true : false
    if state == false
      @error << "Please include a state."
    end
  end

  # RETURNS a Boolean
  def check_create_building_zip_code_is_valid
    zip =  self.zip_code != "" ? true : false
    if zip == false
      @error << "Please include a zip code."
    end
  end

  # RETURNS a Boolean
  def check_create_building_move_in_is_valid
    move_in = self.move_in != "" ? true : false
    if move_in == false
      @error << "Please include a move-in date."
    end
  end

  # RETURNS a Boolean
  def check_create_building_move_out_is_valid
    move_out = self.move_out != "" ? true : false
    if move_out == false
      @error << "Please include a move-out date."
    end
  end

end