class Item < ActiveRecord::Base

  # Method checks title for an empty string.
  #
  # Boolean is set to False if Empty, otherwise Method RETURNS True.
  # RETURNS Boolean. 
  def check_create_item_title_is_valid
    return self.title != "" ? true : false
  end

  # Method checks "condition" for nil value.
  #
  # Boolean is set to False if Empty, otherwise Method RETURNS True.
  # RETURNS Boolean. 
  def check_create_item_condition_is_valid
    return self.condition != nil ? true : false
  end

  # Method authenticates Title and Condition data 
  # by calling Item methods.
  #
  # RETURNS an Array (message) containing the relevant errors.
  def create_item_check_valid_action
    title = check_create_item_title_is_valid
    condition = check_create_item_condition_is_valid
    message = []

    if title == false
      message << item_title_error
    end

    if condition == false
      message << item_condition_error
    end

    return message
  end

  # Method gets integer value from the user input for "condition"
  # and translates that value into an adjective.
  # Method then puts adjective into a variable (value).
  #
  # RETURNS variable "value," which contains a String.
  def get_condition_tag
    value = ""
    
    if self.condition == 5
      value = "Excellent"
    elsif self.condition == 4
      value = "Good"
    elsif self.condition == 3
      value = "Fair"
    elsif self.condition == 2
      value = "Poor"
    elsif self.condition == 1
      value = "Damaged"
    end

    return value
  end


  # Method finds all photos of the object, and deletes them.
  #
  # RETURNS nil
  def find_and_delete_item_photos
    if Photo.where({"item_id" => self.id}) != nil
      photos = Photo.where({"item_id" => self.id}).delete_all
    end
  end

  # Method inspects the object's "created_by" data, and finds the associated
  # User object.
  #
  # RETURNS a User object
  def get_created_by_user_info_for_item
    return self.created_by == nil ?  nil : User.find_by_id(self.created_by)
  end

  # Method inspects the object's "updated_by" data, and finds the associated
  # User object.
  #
  # RETURNS a User object (unless no association found, in which case RETURNS
  # nil).
  def get_updated_by_user_info_for_item
    return self.updated_by == nil ?  nil : User.find_by_id(self.updated_by)
  end

  # Method finds photos of the object, and Returns them.
  #
  # RETURNS a collection of Photo objects, unless none found (then RETURNS
  # nil) 
  def get_item_photos
    return Photo.where({"item_id" => self.id}) == nil ? nil : Photo.where({"item_id" => self.id})
  end


  # Method gives an error message indicating title form field is invalid.
  #
  # RETURNS a String
  def item_title_error
    return "Please include a title when adding or updating a feature."
  end


  # Method gives an error message indicating condition form field is invalid.
  #
  # RETURNS a String
  def item_condition_error
    return "Please set a condition when adding or updating a feature."
  end
  
end