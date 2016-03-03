CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["AWS_ID"],                        # required
    :aws_secret_access_key  => ENV["AWS_SECRET"]                       # required
  }
  config.fog_directory  = 'pair-project'                     # required
end

require 'carrierwave/orm/activerecord'
class MainUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if ENV["RACK_ENV"] == "production"
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end
end
