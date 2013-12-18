module KeyPath
  module StringExtensions
    def to_keypath
      KeyPath::Path.new self
    end
  end
end

class String
  include KeyPath::StringExtensions
end
