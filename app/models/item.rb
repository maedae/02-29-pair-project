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

  def item_title_error
    return "Please include a title when adding a feature."
  end

  def item_condition_error
    return "Please set a condition when adding a new feature."
  end
  
end