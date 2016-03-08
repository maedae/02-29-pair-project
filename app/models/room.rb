class Room < ActiveRecord::Base
  mount_uploader :room_image, MainUploader


  # Method searches all Items for objects associated with the Room, 
  # orders those Items by their "condition" value,
  # and defines the "bad condition" parameter with an array of integers.
  # Items whose condition are included in the array are pushed into an
  # array ("@bad_items").
  #
  # RETURNS an Array of Item objects, if not empty (an empty array will return # a nil value).  
  def find_damaged_items_for_room
    items = Item.where({"room_id" => self.id}) == nil ? nil : Item.where({"room_id" => self.id}).order('condition')
    bad_condition = [1, 2, 3]
    @bad_items = []

    if items != nil
      items.each do |item|
        item_condition = item.condition
        if bad_condition.include?(item_condition)
          @bad_items << item
        end
      end
    end 
    return @bad_items.empty? ? nil : @bad_items
  end

  # Method searches all Items for objects associated with the Room, 
  # orders those Items by their "condition" value,
  # and defines the "good condition" parameter with an array of integers.
  # Items whose condition are included in the array are pushed into an
  # array ("@good_items").
  #
  # RETURNS an Array of Item objects, if not empty (an empty array will return # a nil value).  
  def find_good_items_for_room
    items = Item.where({"room_id" => self.id}) == nil ? nil : Item.where({"room_id" => self.id}).order('condition desc')
    good_condition = [4, 5]
    @good_items = []

    if items != nil
      items.each do |item|
        item_condition = item.condition
        if good_condition.include?(item_condition)
          @good_items << item
        end
      end
    end 
    return @good_items.empty? ? nil : @good_items
  end

  # Method searches all Items for objects associated with the Room,
  # pushes them each into an array, then searches all Photos for 
  # objects associated with each Item object. Method then deletes all
  # associated Photo objects.
  #
  # RETURNS nil
  def find_and_delete_item_photos_for_room
    if Item.where({"room_id" => self.id}) != nil
      item_arr = []
      items = Item.where({"room_id" => self.id})

      items.each do |item|
        item_arr << item.id
      end

      item_arr. each do |item|
        if Photo.where({"item_id" => item}) != nil
          Photo.where({"item_id" => item}).delete_all
        end
      end

    end
  end

  # Method searches all Items for objects associated with the Room,
  # and Deletes all associated Item objects.
  #
  # RETURNS nil
  def find_and_delete_items_for_room
    if Item.where({"room_id" => self.id}) != nil
      Item.where({"room_id" => self.id}).delete_all
    end
  end

  # Method RETURNS the User object associated with the "created_by"
  # attribute of the Room.
  #
  # RETURNS a User object, or nil if "created_by" has no value
  def get_created_by_user_info_for_room
    return self.created_by == nil ?  nil : User.find_by_id(self.created_by)
  end

  # Method RETURNS the User object associated with the "updated_by"
  # attribute of the Room.
  #
  # RETURNS a User object, or nil if "updated_by" has no value
  def get_updated_by_user_info_for_room
    return self.updated_by == nil ?  nil : User.find_by_id(self.updated_by)
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