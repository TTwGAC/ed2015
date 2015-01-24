CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIWLWO3PROZ3GQEQA',
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = "gac2014_#{Rails.env}"
end
