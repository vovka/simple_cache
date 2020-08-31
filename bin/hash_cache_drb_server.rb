require "drb/drb"
require "./lib/hash_cache"

# The URI for the server to connect to
URI = "druby://localhost:8787"

# The object that handles requests on the server
FRONT_OBJECT = HashCache.new

DRb.start_service(URI, FRONT_OBJECT)
# Wait for the drb server thread to finish before exiting.
DRb.thread.join
