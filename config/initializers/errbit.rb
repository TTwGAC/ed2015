Airbrake.configure do |config|
  config.api_key = 'a01df2d5d938217118749d952ae8f295'
  config.host    = 'errors.mojolingo.com'
  config.port    = 80
  config.secure  = config.port == 443
end

