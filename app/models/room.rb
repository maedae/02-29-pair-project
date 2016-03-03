class Room < ActiveRecord::Base

  def find_items_for_room
    @arr_items = []
    if Item.where({"room_id" => self.id}) != nil
      items = Item.where({"room_id" => self.id}).order('condition desc')
      items.each do |i|
        @arr_items << i.id
      end
    end 
    return @arr_items.empty? ? nil : @arr_items
  end

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


  def find_and_delete_item_photos_for_room
    if Item.where({"room_id" => self.id}) != nil
      item_arr = []
      items = Item.where({"room_id" => self.id})

      items.each do |item|
        item_arr = [] << item.id
      end

      item_arr. each do |item|
        if Photo.where({"item_id" => item}) != nil
          Photo.where({"item_id" => item}).delete_all
        end
      end

    end
  end

  def find_and_delete_items_for_room
    if Item.where({"room_id" => self.id}) != nil
      Item.where({"room_id" => self.id}).delete_all
    end
  end

  def get_created_by_user_info_for_room
    return self.created_by == nil ?  nil : User.find_by_id(self.created_by)
  end

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

  def room_title_error
    return "Please include a room type."
  end

  def room_location_error
    return "Please set the location of your room."
  end
  
end