class HashCache < Hash
  def []=(key, expiration_time_millis, value)
    log("Writing #{key}, #{value}")
    super(key, { expires_at: millis + expiration_time_millis, value: value })
  end

  def [](key)
    stored_object = super
    log("Reading #{key}, #{stored_object}")
    stored_object[:value] if !stored_object.nil? && stored_object[:expires_at] > millis
  end

  def cleanup!
    log("cleanup")
    delete_if { |_, v| v[:expires_at] < millis }
    log("done")
  end

  private

  def log(msg)
    # return
    p "#{millis}: "
    p msg
    p self
  end

  def millis
    Time.now.to_f * 1000
  end
end
