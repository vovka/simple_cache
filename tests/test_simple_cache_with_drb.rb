require "minitest/autorun"
require "byebug"
require "fileutils"
require_relative "../lib/simple_cache"
require_relative "../lib/hash_cache_drb_client"

class TestSimpleCacheWithDrb < Minitest::Test
  EXPIRATION_TIME_MILLIS = 50.0.freeze

  def setup
    super
    puts "\nEnsure you've run `ruby #{File.expand_path("#{__FILE__}/../../bin/hash_cache_drb_server.rb")}`"
    SimpleCache.config = { backend: HashCacheDrbClient }
  end

  def test_write_value
    assert_equal(1, SimpleCache.write("test_write_value_key", 1))
  end

  def test_write_nil_value
    assert_nil(SimpleCache.write("test_write_nil_value_key", nil))
  end

  def test_write_block
    assert_equal(1, SimpleCache.write("test_write_block_key") { 1 })
  end

  def test_write_nil_value_with_block
    assert_equal(1, SimpleCache.write("test_write_nil_value_with_block_key", nil) { 1 })
  end

  def test_read
    SimpleCache.write("test_read_key", 1)
    assert_equal(1, SimpleCache.read("test_read_key"))
  end

  def test_fetch
    assert_equal(1, SimpleCache.fetch("test_fetch_key") { 1 })
  end

  def test_expiration_time
    SimpleCache.config = SimpleCache.config.merge({ expiration_time_millis: EXPIRATION_TIME_MILLIS })
    SimpleCache.write("test_expiration_time_key", 1)
    sleep(EXPIRATION_TIME_MILLIS / 1000)
    assert_nil(SimpleCache.read("test_expiration_time_key"))
  end
end
