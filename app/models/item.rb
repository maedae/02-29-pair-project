## Class exists as an instance of a User's desire to examine something at a narrower focus than the Room level. A Building has Rooms, which have Items. 
class Item < ActiveRecord::Base
  belongs_to :room
  has_many :photos
  validates :title, :condition, presence: true


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

end