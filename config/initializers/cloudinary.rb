require "cloudinary"
require "cloudinary/carrier_wave"

CarrierWave::Uploader::Base.storage_engines[:cloudinary] = "Cloudinary::CarrierWave::Storage"
