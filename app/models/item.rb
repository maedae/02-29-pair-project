class Item < ActiveRecord::Base
  
  def check_create_item_title_is_valid
    return self.title != "" ? true : false
  end

  def check_create_item_condition_is_valid
    return self.condition != nil ? true : false
  end

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

  def find_and_delete_item_photos
    if Photo.where({"item_id" => self.id}) != nil
      photos = Photo.where({"item_id" => self.id}).delete_all
    end
  end

  def get_created_by_user_info_for_item
    return self.created_by == nil ?  nil : User.find_by_id(self.created_by)
  end

  def get_updated_by_user_info_for_item
    return self.updated_by == nil ?  nil : User.find_by_id(self.updated_by)
  end

  def get_item_photos
    return Photo.where({"item_id" => self.id}) == nil ? nil : Photo.where({"item_id" => self.id})
  end


  def item_title_error
    return "Please include a title when adding or updating a feature."
  end

  def item_condition_error
    return "Please set a condition when adding or updating a feature."
  end
  
end