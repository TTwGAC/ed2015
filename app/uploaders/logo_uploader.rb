class LogoUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']

  version :index do
    process :resize_to_fill => [24, 24, :north]
  end

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  def default_url
    ActionController::Base.helpers.asset_path 'confusion.jpg'
  end

end
