class Photo < ActiveRecord::Base
  mount_uploader :image, MainUploader
end