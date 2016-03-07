class Room < ActiveRecord::Base
  mount_uploader :room_image, MainUploader

  def initialize 
    @items_collection = Item.where({"room_id" => self.id})
    @item_id_array = []
    @bad_items = {}
    @good_items = {}
    @creator = nil
    @editor = nil
  end

  #RETURNS nil OR @items_collection instance variable
  def get_find_items_for_room
    return @items_collection
  end

  # Method finds all Item Object instances where "room_id" matches the current Room Instance ID && stores the item id in @item_id_array instance variable.
  # SETS Array of Item Collection IDs to Instance Variable @item_id_array
  def set_items_id_array_for_room
    @item_id_array = Item.where({"room_id" => self.id}).pluck(:id)
  end


  #RETURNS nil OR @item_id_array instance variable
  def get_items_id_array_for_room
    return @item_id_array
  end

  # Method searches all Items for objects associated with the Room, 
  # orders those Items by their "condition" value,
  # and defines the "bad condition" parameter with an array of integers.
  # Items whose condition are included in the array are pushed into an
  # array ("@bad_items").
  def set_find_damaged_items_for_room
    @bad_items = Item.where({"room_id" => self.id, "condition" => 1..3}).order('condition')
  end


  # RETURNS an hash of Item objects or an empty hash
  def get_find_damaged_items_for_room
    return @bad_items
  end

  # Method searches all Items for objects associated with the Room, 
  # orders those Items by their "condition" value,
  # and defines the "good condition" parameter with an array of integers.
  # Items whose condition are included in the array are pushed into an
  # array ("@good_items").
  #
  # RETURNS an Array of Item objects, if not empty (an empty array will return # a nil value).  
  def set_find_good_items_for_room
    @good_items = Item.where({"room_id" => self.id, "condition" => 4..5}).order('condition desc')
  end

  def get_find_good_items_for_room
    return @good_items
  end

  # Method searches all Items for objects associated with the Room,
  # pushes them each into an array, then searches all Photos for 
  # objects associated with each Item object. Method then deletes all
  # associated Photo objects.
  #
  # RETURNS nil
  def find_and_delete_item_photos_for_room
      @item_id_array. each do |item|
        item_photo = Photo.where({"item_id" => item}) 
        if item_photo != nil
          item_photo.delete_all
        end
      end
  end

  # Method searches all Items for objects associated with the Room,
  # and Deletes all associated Item objects.
  #
  # RETURNS nil
  def find_and_delete_items_for_room
     Item.where({"room_id" => self.id}).delete_all if @items_collection != nil
  end

  # Method RETURNS the User object associated with the "created_by"
  # attribute of the Room.
  #
  # RETURNS a User object, or nil if "created_by" has no value
  def set_created_by_user_info_for_room
    @creator = User.find_by_id(self.created_by)
  end

  def get_created_by_user_info_for_room
    return @creator
  end

  # Method RETURNS the User object associated with the "updated_by"
  # attribute of the Room.
  #
  # RETURNS a User object, or nil if "updated_by" has no value
  def set_updated_by_user_info_for_room
    @editor = User.find_by_id(self.updated_by)
  end

  def get_updated_by_user_info_for_room
    return @editor
  end

  # RETURNS Boolean if title value String is empty or not
  def check_create_room_title_is_valid
      return self.title != "" ? true : false
  end

  # RETURNS Boolean if location value String is empty or not
  def check_create_room_location_is_valid
      return self.location != nil ? true : false
  end

  # Method calls on pre-existing Methods to validate input data
  # for "title" and "location". 
  #
  # RETURNS an Array of errors, which are Strings
  # (created by Methods "room_title_error" and "room_location_error") 
  def create_room_check_valid_action
    title = check_create_room_title_is_valid
    location = check_create_room_location_is_valid
    message = []

    if title == false
      message << room_title_error
    end

    if location == false
      message << room_location_error
    end

    return message
  end
  
  # RETURNS an error in the form of a String
  def room_title_error
    return "Please include a room type."
  end

  # RETURNS an error in the form of a String
  def room_location_error
    return "Please set the location of your room."
  end
  
end