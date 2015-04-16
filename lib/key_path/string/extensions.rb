require 'active_support/inflector'

module KeyPath
  # Extensions to `String`.
  module StringExtensions
    def to_keypath
      KeyPath::Path.new self
    end

    def is_singular?
      pluralize != self && singularize == self
    end

    def is_plural?
      singularize != self && pluralize == self
    end

    def is_number?
      true if Float(self) rescue false
    end
  end
end

# Mix `StringExtensions` into `String`.
class String
  include KeyPath::StringExtensions
end
