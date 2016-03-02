class Building < ActiveRecord::Base

  def find_rooms_for_building
    arr_rooms = []
    if Room.where({"building_id" => self.id}) != nil
      rooms = Room.where({"building_id" => self.id})
      rooms.each do |r|
        arr_rooms << r.id
      end
    end 

    return arr_rooms.empty? ? nil : arr_rooms
  end

  def get_updated_by_user_info
    return self.updated_by == nil ?  nil : User.find_by_id(self.created_by)
  end
end