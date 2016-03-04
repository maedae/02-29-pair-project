class Photo < ActiveRecord::Base
  mount_uploader :image, MainUploader

  # Method RETURNS an error consisting of a String.
  def no_image_error
    return "Please select an image to add."
  end

end