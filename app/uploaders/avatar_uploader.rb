require "cloudinary"
require "cloudinary/carrier_wave"

class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  storage :cloudinary

  version :thumb do
    process resize_to_fit: [ 100, 100 ]
  end

  version :medium do
    process resize_to_fit: [ 300, 300 ]
  end

  def content_type_whitelist
    /image\//
  end

  def size_range
    0..5.megabytes
  end
end
