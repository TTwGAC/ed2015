CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => '2d824bf2b4e9c3d83b64a77eb0e5981305bc49531f6b48ec5352a2e9175c8ef30aebecdba49fd38d890458a1a8d0ee48926f50c54f190e8fcecad4d65636e7ed'
  }
  config.fog_directory  = "gac2014_#{Rails.env}"
end
