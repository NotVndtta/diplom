require "cloudinary"
require "cloudinary/carrier_wave"

class FileUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  storage :cloudinary

  def extension_allowlist
    %w[jpg jpeg png mp4 mov pdf webm]
  end

  def size_range
    0..10.megabytes
  end
end
