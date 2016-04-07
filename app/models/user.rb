class User < ActiveRecord::Base
  has_many :buildings, through: :renters
  # Method  checks if email value String is empty or not
  #
  # RETURNS Boolean value 
  def check_create_user_email_is_valid
    return self.email != "" ? true : false
  end

  # Method  checks if user name value String is empty or not
  #
  # RETURNS Boolean value
  def check_create_user_name_is_valid
    return self.name != "" ? true : false
  end

  # Method  checks if user password value String is empty or not
  #
  # RETURNS Boolean value
  def check_create_user_password_is_valid
    return self.password != "" ? true : false
  end

  # Method looks at boolean values from other methods to determine what sign
  # up errors have appeared. 
  # Calls other methods if values are false
  #
  # email  - calls on pre-existing method. stores Boolean return value
  # name - calls on pre-existing method. stores Boolean return value
  # password - calls on pre-existing method. stores Boolean return value
  # message - empty Array. will store Strings via method return values when
  # applicable
  # user_name_error - Method returns String value
  # user_email_error - Method returns String value
  # user_password_error -Method returns String value
  #
  # Returns Array containing 3 - 0 String elements, depending on Method
  # algorithm outcome
  def create_user_check_valid_action
    email = check_create_user_email_is_valid
    name =  check_create_user_name_is_valid
    password = check_create_user_password_is_valid
    message = []

    if name == false
      message << user_name_error
    end

    if email == false
      message << user_email_error
    end

    if password == false
      message << user_password_error
    end
    return message
  end
  
  # RETURNS array of building_id column data from Renter collection 
  def find_user_renter_building_info
    arr_renters = []
    if Renter.where({"user_id" => self.id}) != nil
      renters = Renter.where({"user_id" => self.id})
      renters.each do |r|
        arr_renters << r.building_id
      end
    end 

    return arr_renters.empty? ? nil : arr_renters
  end

  # RETURNS Array of ids column data from Buildig collection if building row
  # is flagged as locked.
  def past_building_info_for_renter_based_on_user_id
    renters = find_user_renter_building_info
    past_buildings = []

    if renters != nil
      renters.each do |r|
        building = Building.find_by_id(r)
        if building.locked == true 
          past_buildings << building.id
        end
      end
    end

    return past_buildings.empty? ? nil : past_buildings 
  
  end

  # RETURNS Array of ids column data from Buildig collection if building row
  # is not flagged as locked.
  def current_building_info_for_renter_based_on_user_id
    renters = find_user_renter_building_info
    open_buildings = []

    if renters != nil
      renters.each do |r|
        building = Building.find_by_id(r)
        if building.locked == false
          open_buildings << building.id
        end
      end
    end
   
    return open_buildings.empty? ? nil : open_buildings
  end

    # Method checks to see if a user exists in the database based on arguement passed into method.
  #
  # arr = email
  #
  # Returns nil or Row in User table depending on outcome.
  def see_if_user_exists(arr)
    return User.find_by_email(arr)
  end


  # RETURNS String
  def user_name_error
    return "Please include your name."
  end

  # RETURNS String
  def user_email_error
    return "Please include your email."
  end

  # RETURNS String
  def user_password_error
    return "Please include a password."
  end

  # RETURNS String
  def user_already_exists_error
    return "A user with this email already exists. Please sign into that account or select a different email"
  end
end