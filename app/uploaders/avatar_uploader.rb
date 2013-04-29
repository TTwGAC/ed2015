class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']

  version :standard do
    process :resize_to_fill => [150, 150, :north]
  end

  version :thumbnail do
    resize_to_fit 50, 50
  end

  def default_url
	  "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(model.email.downcase)}.png?s=150&d=mm&r=pg"
  end

end
