require_relative "config/drb"

SimpleCache.write(:test, Time.now.to_f)
p 1000.times.map { SimpleCache.read(:test) }
p 1000.times.map { SimpleCache.fetch(:test) { Time.now.to_f } }
