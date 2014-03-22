require 'thread'

class DudeExcellent
  HOSTED_AUDIO_PATH = 'http://hosting.tropo.com/49286/www/dude_excellent'

  def initialize(scope)
    @scope = scope
  end

  def show(message)
    log "********* GAME: #{message}"
  end


  def main_incoming

    # We have an inbound connection
    case $currentCall.channel
    when "VOICE"
      # We have an inbound call
      answer
      say "Dude. What gives. Don't call me at this number."
      hangup
      throw :done
    when "TEXT"
      # We have an inbound text
      @source      = validate_number $currentCall.callerID
      @destination = validate_number $currentCall.initialText

      reject_invalid_sms

      show "Validated numbers: From #{@source} to #{@destination}"

      t = async do
        @player2 = dial @destination
        sleep 2
        @player2.say "Dude! You are player 2! Excellent!"
        @player2.say "Hang tight while we get all the players"
      end

      @player1 = dial @source
      sleep 2
      @player1.say "Excellent! You are player 1! Dude!"
      @player1.say "Hang tight while we get all the players"
      t.join

      throw :done if @player1.nil? && @player2.nil?

      if @player1.nil?
        @player2.say "Bummer. We couldn't get the other player.  Frownie face."
        @player2.hangup
        throw :done
      end

      if @player2.nil?
        @player1.say "Bummer. We couldn't get the other player.  Frownie face."
        @player1.hangup
        throw :done
      end

      sync_say "Player 1. Whenever you hear the word dude, you should repeat it out loud. Player 2. Whenever you hear the word excellent, you should repeat it out loud.  Each player should only repeat their own word.  Whenever you hear the air guitar, you should make the appropriate motion.  Everybody ready? Ok, here we go."

      sleep 1

      sync_say "#{HOSTED_AUDIO_PATH}/player1.wav", "#{HOSTED_AUDIO_PATH}/player2.wav"

      sync_say "Thank you for playing.  Good bye."
    end

  end

  def sync_say(p1string, p2string = nil)
    p2string ||= p1string
    waiters = []
    waiters << async { @player1.say p1string }
    waiters << async { @player2.say p2string }
    waiters.each { |t| t.join }
  end

  def async(&block)
    Thread.new do
      catching_standard_errors do
        block.call
      end
    end
  end

  def dial(number)
    show "Calling #{number}"
    event = call "tel:#{number}", 'callerID' => '14045964437', 'network' => 'PSTN'
    show "returning #{event.value.inspect}"
    event.value
  end


  ##
  # Attempt to ensure we have a valid NANPA number
  def validate_number(input)
    digits = input.gsub /[^\d]/, ''
    digits = "1#{digits}" unless digits =~ /^1/
    digits = "+#{digits}" unless digits =~ /^\+/
    digits = nil unless digits.length == 12
    digits
  end


  def reject_invalid_sms
    message = nil

    if @destination == @source
      response = "SOMEBODY isn't following directions..."
    end

    if @destination.nil?
      response = 'I don\'t get it. Who did you want me to call?'
    end

    if response
      message response, 'to' => $currentCall.callerID, 'network' => 'SMS'
      hangup
      throw :done
    end
  end

  def catching_standard_errors(&block)
    begin
      yield if block_given?
    rescue => e
      show "EXCEPTION! #{e.message}"
      show "********** #{e.backtrace.join "\n"}"
    end
  end
end

if $currentCall
  game = DudeExcellent.new self
  catch :done do
    game.main_incoming
  end
end
