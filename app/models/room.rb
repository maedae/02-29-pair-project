# Class is the instance of room data created by user.
# each room has one building, and can have many items. 
class Room < ActiveRecord::Base
  mount_uploader :room_image, MainUploader

  #RETURNS Collection of Item instances.
  def find_items_for_room
    return Item.where({"room_id" => self.id})
  end

  # Method finds all Item Object instances where "room_id" matches the current Room Instance ID && stores the item id in @item_id_array instance variable.
  # SETS Array of Item Collection IDs to Instance Variable @item_id_array
  def find_items_id_array_for_room
    return Item.where({"room_id" => self.id}).pluck(:id)
  end

  # Method searches all Items for objects associated with the Room, 
  # orders those Items by their "condition" value,
  # and defines the "bad condition" parameter with an array of integers.
  # Items whose condition are included in the array are pushed into an
  # array ("@bad_items").
  def find_damaged_items_for_room
    return Item.where({"room_id" => self.id, "condition" => 1..3}).order('condition')
  end

  # Method searches all Items for objects associated with the Room, 
  # orders those Items by their "condition" value,
  # and defines the "good condition" parameter with an array of integers.
  # Items whose condition are included in the array are pushed into an
  # array ("@good_items").
  #
  # RETURNS an Array of Item objects, if not empty (an empty array will return # a nil value).  
  def find_good_items_for_room
    return Item.where({"room_id" => self.id, "condition" => 4..5}).order('condition desc')
  end

  # Method searches all Items for objects associated with the Room,
  # and Deletes all associated Item objects.
  #
  # RETURNS nil
  def find_and_delete_items_for_room
     Item.where({"room_id" => self.id}).delete_all
  end

  # Method RETURNS the User object associated with the "created_by"
  # attribute of the Room.
  #
  # RETURNS a User object, or nil if "created_by" has no value
  def find_created_by_user_info_for_room
    return User.find_by_id(self.created_by)
  end

  # Method RETURNS the User object associated with the "updated_by"
  # attribute of the Room.
  #
  # RETURNS a User object, or nil if "updated_by" has no value
  def find_updated_by_user_info_for_room
    editor = self.updated_by
    return editor != nil ? User.find_by_id(editor) : nil
  end

  # RETURNS Boolean if location value String is empty or not
  def check_create_room_location_is_valid
    location = self.location != nil ? true : false
    if location == false
      @error << "Please set the location of your room."
    end
  end

  # Method calls on pre-existing Methods to validate input data
  # for "title" and "location". 
  #
  # RETURNS an Array of errors, which are Strings
  # (created by Methods "room_title_error" and "room_location_error") 
  def check_create_room_title_is_valid
    title = self.title != "" ? true : false
    if title == false
      @error << "Please include a room type."
    end
  end

  def room_error_check
    @error = []
    check_create_room_title_is_valid
    check_create_room_location_is_valid
    return @error
  end
  
end