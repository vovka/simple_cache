require_relative ".././lib/hash_cache_drb_client"

Process.daemon

client = HashCacheDrbClient.new
expiration_time = (ARGV[0].to_f || 50) / 1000

while true do
  sleep(expiration_time)
  client.cleanup!
end
