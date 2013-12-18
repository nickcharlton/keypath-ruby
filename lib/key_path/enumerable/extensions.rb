module Enumerable
  # see: http://stackoverflow.com/a/7139631/83386
  def value_at_keypath(dotted_path)
    parts = dotted_path.split '.', 2
    
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
    p "#{keypath} => #{value}"
  end
end

