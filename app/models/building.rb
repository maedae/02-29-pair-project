class Building < ActiveRecord::Base

  mount_uploader :building_image, MainUploader
  
  # Method finds all associated Rooms for a Building,
  # and puts each into an Array.
  #
  # Returns an Array of Room IDs(@arr_rooms)
  # If the Array is empty, method RETURNS nil
  def find_rooms_for_building
    @arr_rooms = []
    if Room.where({"building_id" => self.id}) != nil
      rooms = Room.where({"building_id" => self.id})
      rooms.each do |r|
        @arr_rooms << r.id
      end
    end 
    return @arr_rooms.empty? == false ? @arr_rooms : nil
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

  def get_updated_by_user_info
    return self.updated_by == nil ?  nil : User.find_by_id(self.created_by)
  end

  # Method conducts validation on input from form fields
  # by calling other methods
  #
  # Initializes an Array (message), and puts a message specific to an error
  # into it when the validation fails.
  # Method RETURNS an Array (message).
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

  # ____________________________________________________
  #
  # Methods below check each chunk of form data to validate their contents.
  # If the form data passes or fails,  
  #
  # Each RETURNS a corresponding Boolean value
  def check_create_building_address_is_valid
    return self.address != "" ? true : false
  end
  
  # RETURNS a Boolean
  def check_create_building_city_is_valid
    return self.city != "" ? true : false
  end

  # RETURNS a Boolean
  def check_create_building_state_is_valid
    return self.state != "" ? true : false
  end

  # RETURNS a Boolean
  def check_create_building_zip_code_is_valid
    return self.zip_code != "" ? true : false
  end

  # RETURNS a Boolean
  def check_create_building_move_in_is_valid
    return self.move_in != nil ? true : false
  end

  # RETURNS a Boolean
  def check_create_building_move_out_is_valid
    return self.move_out != nil ? true : false
  end
  # ______________________________________________

  # Method checks to see if a user exists in the database based on arguement passed into method.
  #
  # arr = email
  #
  # Returns nil or Row in User table depending on outcome.
  def see_if_user_exists(arr)
    return User.find_by_email(arr) == nil ? nil : User.find_by_email(arr)
  end


  # ______________________________________________

  # Methods below define the error messages used in
  # Method (create_building_check_valid_action)
  # 

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
  #______________________________________________

end