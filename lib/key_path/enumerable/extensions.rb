module Enumerable
  # see: http://stackoverflow.com/a/7139631/83386
  def value_at_keypath(keypath)
    if keypath.is_a?(KeyPath::Path)
      keypath = keypath.to_s
    end

    parts = keypath.split '.', 2
    
    # if it's an array, call the index
    if self[parts[0].to_i]
      match = self[parts[0].to_i]
    else
      match = self[parts[0]] || self[parts[0].to_sym]
    end
    
    if !parts[1] or match.nil?
      return match
    else
      return match.value_at_keypath(parts[1])
    end
  end

  def set_keypath(keypath, value)
    # handle both string and KeyPath::Path forms
    if keypath.is_a?(String)
      keypath = keypath.to_keypath
    end

    # create a collection at the keypath
    collection = keypath.to_collection
    
    # set the value in the collection
    depth = ''
    keypath.to_a.each do |e|
      # walk down set and make up the right place to assign
      if e.is_number?
        key = "#{e}"
      else
        key = ":#{e}"
      end
      depth << "[#{key}]"
    end

    # assign it
    if value.is_a? String
      eval "collection#{depth} = '#{value}'"
    else
      eval "collection#{depth} = #{value}"
    end
    
    # merge the new collection into self
    self.deep_merge!(collection)
  end
end

