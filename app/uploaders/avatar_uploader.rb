class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']

  version :index do
    process :resize_to_fit => [24, 24, :center]
  end

  version :standard do
    process :resize_to_fit => [300, 300, :center]
  end

  version :thumbnail do
    resize_to_fit 50, 50
  end

  def default_url
	  "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(model.email.downcase)}.png?s=150&d=mm&r=pg"
  end

end
