require "singleton"
require_relative "hash_cache"

class SimpleCache
  class << self
    def config
      @config ||= {}
    end

    def config=(hash = {})
      @instance = nil
      @config = hash
    end

    def write(key, value = nil, &block)
      instance.write(key, if block_given?
        yield
      else
        value
      end)
    end

    def read(key)
      instance.read(key)
    end

    def fetch(key, &block)
      if block_given?
        read(key) || write(key, &block)
      else
        read(key)
      end
    end

    def cleanup!
      instance.storage.cleanup! if instance.storage.respond_to?(:cleanup!)
    end

    private

    def instance
      @instance ||= new
    end
  end

  DEFAULT_EXPIRATION_TIME = 50.freeze
  DEFAULT_BACKEND = HashCache

  def initialize
    config = self.class.config || {}
    @storage = (config[:backend] || DEFAULT_BACKEND).new
    @expiration_time_millis = config[:expiration_time_millis] || DEFAULT_EXPIRATION_TIME
  end

  def storage
    @storage
  end

  def write(key, value)
    storage[key, @expiration_time_millis] = value
  end

  def read(key)
    storage[key]
  end
end
