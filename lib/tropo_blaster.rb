# encoding: utf-8

class TropoBlaster
  def self.blast(callerid, targets, message, mode)
    params = {
      token:    ENV['TROPO_TOKEN'],
      callerid: callerid,
      targets:  targets.to_json, # Hack to get around Tropo's nested params limitation
      message:  message,
      mode:     mode
    }

    Faraday.post("http://api.tropo.com/1.0/sessions") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
      req.body = params.to_json
    end
  end
end
