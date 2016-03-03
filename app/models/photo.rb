class Photo < ActiveRecord::Base
  mount_uploader :image, MainUploader


  def no_image_error
    return "Please select an image to add."
  end

end