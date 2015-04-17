module Enumerable
  # see: http://stackoverflow.com/a/7139631/83386
  def value_at_keypath(keypath)
    keypath = keypath.to_s if keypath.is_a?(KeyPath::Path)

    parts = keypath.split '.', 2

    # if it's an array, call the index
    if self[parts[0].to_i]
      match = self[parts[0].to_i]
    else
      match = self[parts[0]] || self[parts[0].to_sym]
    end

    if !parts[1] || match.nil?
      return match
    else
      return match.value_at_keypath(parts[1])
    end
  end

  def set_keypath(keypath, value)
    # handle both string and KeyPath::Path forms
    keypath = keypath.to_keypath if keypath.is_a?(String)

    keypath_parts = keypath.to_a
    # Return self if path empty
    return self if keypath_parts.empty?

    key = keypath_parts.shift
    # Just assign value to self when it's a direct path
    # Remember, this is after calling keypath_parts#shift
    if keypath_parts.length == 0
      key = key.is_number? ? Integer(key) : key.to_sym

      self[key] = value
      return self
    end

    # keypath_parts.length > 0
    # Remember, this is after calling keypath_parts#shift
    collection = if key.is_number?
      Array.new
    else
      Hash.new
    end

    # Remember, this is after calling keypath_parts#shift
    collection.set_keypath(keypath_parts.join('.'), value)

    # merge the new collection into self
    self[key] = collection
  end
end
