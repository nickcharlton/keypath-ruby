module KeyPath
  module String
    module KeyPathExtensions
      def to_keypath
        KeyPath::Path.new self
      end
    end
  end
end

class String
  include KeyPath::String::KeyPathExtensions
end
