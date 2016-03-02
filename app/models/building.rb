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
end