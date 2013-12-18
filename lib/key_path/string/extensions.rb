require 'active_support/inflector'

module KeyPath
  module StringExtensions
    def to_keypath
      KeyPath::Path.new self
    end

    def is_singular?
      self.pluralize != self and self.singularize == self
    end

    def is_plural?
      self.singularize != self and self.pluralize == self
    end

    def is_number?
      true if Float(self) rescue false
    end
  end
end

class String
  include KeyPath::StringExtensions
end
