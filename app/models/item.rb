## Class exists as an instance of a User's desire to examine something at a narrower focus than the Room level. A Building has Rooms, which have Items. 
class Item < ActiveRecord::Base
  belongs_to :room
  has_many :photos

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
  # by calling condition_check and title_check methods.
  #
  # RETURNS an Array (message) containing the relevant errors.
  def create_item_check_valid_action
    @message = []
    condition_check
    title_check
    return @message
  end

  # Method checks the condition for validity, and throws the proper error 
  # message into the Array "message".
  #
  # RETURNS nil
  def condition_check
    if check_create_item_condition_is_valid == false
      @message << item_condition_error
    end
  end

  # Method checks the condition for validity, and throws the proper error 
  # message into the Array "message".
  #
  # RETURNS nil
  def title_check
    if check_create_item_title_is_valid == false
      @message << item_title_error
    end
  end

  # Method sets "@value" variable to "", and calls method to create a hash.
  # @condition is set to the integer returned from "condition" method,
  # and is used in "get_condition_string" method to find the value (a String)
  # associated with the integer "@condition"
  #
  # RETURNS the variable "@value," which is a String.
  def get_condition_tag
    @value = ""
    create_condition_hash
    @condition = self.condition
    get_condition_string 
    return @value
  end

  # Method creates a hash with integers that correspond to Strings, 
  # for the "get_condition_tag" method.
  #
  # Returns nil
  def create_condition_hash
    @condition_hash = {1 => "Damaged", 2 => "Poor", 3 => "Fair", 4 => "Good", 5 => "Excellent"}
  end
  
  # Method searches the hash from "create_condition_hash" for a value matching
  # the key "@condition"
  #
  # Returns nil
  def get_condition_string
    @value = @condition_hash[@condition]
  end

  # Method finds all photos of the object, and deletes them.
  #
  # RETURNS nil
  def find_and_delete_item_photos
    photos = Photo.where({"item_id" => self.id})
      if photos != nil
        photos.delete_all
      end
  end

  # Method inspects the object's "created_by" data, and finds the associated
  # User object.
  #
  # RETURNS a User object
  def get_created_by_user_info_for_item
    creator = User.find_by_id(self.created_by)
    if creator != nil
      return creator
    end
  end

  # Method inspects the object's "updated_by" data, and finds the associated
  # User object.
  #
  # RETURNS a User object (unless no association found, in which case RETURNS
  # nil).
  def get_updated_by_user_info_for_item
    updater = User.find_by_id(self.updated_by)
    if updater != nil
      return updater
    end 
  end

  # Method finds photos of the object, and Returns them.
  #
  # RETURNS a collection of Photo objects, unless none found (then RETURNS
  # nil) 
  def get_item_photos
    item_photos = Photo.where({"item_id" => self.id})
    if item_photos != nil
      return item_photos
    end
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