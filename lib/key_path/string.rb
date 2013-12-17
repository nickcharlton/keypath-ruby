class String
  def to_keypath
    KeyPath::Path.new self
  end
end
