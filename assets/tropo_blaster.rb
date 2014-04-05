require 'net/http'
require 'json'

CONTACT = 'CHANGEME' # This should be a phone number to which responses are routed
WEB_UI_URL = 'http://smsblast.herokuapp.com' # This should be the URL to your app

def send_confirmation(id)
  uri = URI.parse "#{WEB_UI_URL}/tropo/update"
  params = { :token => $token, :id => id, :status => "Sent" }
  Net::HTTP.post_form uri, params
end


if $currentCall
  case $currentCall.channel.downcase
  when 'voice'
    transfer CONTACT
  when 'text'
    message "#{$currentCall.callerID}: #{$currentCall.initialText}", :to => CONTACT, :network => 'SMS'
  end
else
  targets = JSON.parse $targets
  log "Targets: #{targets.inspect}"
  log "Message: #{$message.inspect}"
  mode = case $mode
  when 'sms'
    'SMS'
  when 'phone'
    'PSTN'
  else
    'SMS'
  end
  threads = []
  targets.each_pair do |id, target|
    if mode == 'SMS'
      # These must be serial
      call target, :callerID => $callerid, :network => mode
      say $message
      hangup
      #send_confirmation id
      sleep 1
    else
      # Voice can be done in parallel
      threads << Thread.new do
        c = call(target, :callerID => $callerid, :network => mode).value
        c.say $message
        c.hangup
      end
    end
  end

  threads.each {|t| t.join}
end

