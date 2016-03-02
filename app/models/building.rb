class Building < ActiveRecord::Base

  def find_rooms_for_building
    arr_rooms = []
    if Room.where({"building_id" => self.id}) != nil
      rooms = Room.where({"building_id" => self.id})
      rooms.each do |r|
        arr_rooms << r.id
      end
    end 
    return arr_rooms.empty? ? nil : arr_rooms
  end
  
  def check_if_building_has_other_renters
      renters = Renter.exists?(:building_id => self.id)
      if renters == false
        self.delete
      end
  end

  def create_building_check_valid_action
    address = check_create_building_address_is_valid
    city = check_create_building_city_is_valid
    state = check_create_building_state_is_valid
    zip = check_create_building_zip_code_is_valid
    move_in = check_create_building_move_in_is_valid
    move_out = check_create_building_move_out_is_valid
    message = []

    if address == false
      message << address_error
    end

    if city == false
      message << city_error
    end

    if state == false
      message << state_error
    end

    if zip == false
      message << zip_error
    end
   
    if move_in == false
      message << move_in_error
    end

     if move_out == false
      message << move_out_error
    end
    
    return message
  end

  def get_updated_by_user_info
    return self.updated_by == nil ?  nil : User.find_by_id(self.created_by)
  end

  def check_create_building_address_is_valid
    return self.address != "" ? true : false
  end
  
  def check_create_building_city_is_valid
    return self.city != "" ? true : false
  end

  def check_create_building_state_is_valid
    return self.state != "" ? true : false
  end

  def check_create_building_zip_code_is_valid
    return self.zip_code != "" ? true : false
  end

  def check_create_building_move_in_is_valid
    return self.move_in != nil ? true : false
  end

  def check_create_building_move_out_is_valid
    return self.move_out != nil ? true : false
  end

  # RETURNS String
  def address_error
    return "Please include an address."
  end

  # RETURNS String
  def city_error
    return "Please include a city."
  end
  
  # RETURNS String
  def state_error
    return "Please include a state."
  end

  # RETURNS String
  def zip_error
    return "Please include a zip code."
  end

  # RETURNS String
  def move_in_error
    return "Please include a move-in date."
  end

  # RETURNS String
  def move_out_error
    return "Please include a move-out date."
  end
end