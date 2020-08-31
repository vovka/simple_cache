require 'drb/drb'

class HashCacheDrbClient
  # The URI to connect to
  SERVER_URI = "druby://localhost:8787".freeze

  def self.new
    # Start a local DRbServer to handle callbacks.
    #
    # Not necessary for this small example, but will be required
    # as soon as we pass a non-marshallable object as an argument
    # to a dRuby call.
    #
    # Note: this must be called at least once per process to take any effect.
    # This is particularly important if your application forks.
    DRb.start_service

    DRbObject.new_with_uri(SERVER_URI)
  end
end
