require 'digest'

module Utility
  class << self
    def gen_token
      # Yes, this is not ideal but it's probably good enough
      Digest::MD5.hexdigest "#{Time.now}-#{Time.now.nsec}-#{rand 99999}"
    end
  end
end
