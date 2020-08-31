# First run `ruby bin/hash_cache_drb_server.rb`.
# Run `ruby bin/hash_cache_cleanup_daemon.rb` if you need automatic cleanup.
require_relative "../lib/simple_cache.rb"
require_relative "../lib/hash_cache_drb_client"

SimpleCache.config = { backend: HashCacheDrbClient, expiration_time_millis: 50 }
