# Class is the instance of an image uploaded by the User, 
# and each is associated with a Building, Room, or an Item.
class Photo < ActiveRecord::Base
  mount_uploader :image, MainUploader
  belongs_to :item

  # Method RETURNS an error consisting of a String.
  def no_image_error
    return "Please select an image to add."
  end

  # Method searches all Items for objects associated with the Room,
  # pushes them each into an array, then searches all Photos for 
  # objects associated with each Item object. Method then deletes all
  # associated Photo objects.
  #
  def find_and_delete_item_photos_for_room(item_id_arr)
      item_id_arr. each do |item|
        item_photo = Photo.where({"item_id" => item}) 
        if item_photo != nil
          item_photo.delete_all
        end
      end
  end

end