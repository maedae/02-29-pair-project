# Class is the handles instances of Building Object created by the User, 
# Each building can belong to multiple Renter Instances. Each building can have multiple Room instances.
class Building < ActiveRecord::Base
  has_many :rooms
  has_many :users, through: :renters
  validates :address, :city, :state, :zip_code, :move_in, :move_out, presence: true

  mount_uploader :building_image, MainUploader

  # Method Passes in building instance ID and user ID. Searches for the renter with those perimeters and deletes the renter.
  def delete_renter_when_deleting_building(user_id)
    Renter.where({"user_id" => user_id, "building_id" => self.id}).delete_all
  end
  
  # Method searches for Renters by their Building IDs
  #
  # If there are no renters found, the building is deleted. 
  # RETURNS nil
  def check_if_building_has_other_renters
      renters = Renter.exists?(:building_id => self.id)
      if renters == false
        self.delete
      end
  end

  def get_created_by_user_info
        user = User.find_by_id(self.created_by)
    return user != nil ?  user.name : nil
  end

  def get_updated_by_user_info
    user = User.find_by_id(self.updated_by)
    return user != nil ?  user.name : nil
  end
end