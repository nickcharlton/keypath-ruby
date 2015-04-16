module KeyPath
  # The class representing a Path in a collection object.
  class Path
    def initialize(path = '')
      @path = path
    end

    def parent
      s = to_a
      s.pop

      # there's no parent if it's empty
      return nil if s == []

      # otherwise, join them back together and pass back a path
      s.join('.').to_keypath
    end

    def to_s
      @path
    end

    def to_a
      @path.split('.')
    end

    def to_collection
      collection = {}
      s = to_a
      depth = ''

      s.each do |e|
        # assemble the key
        if e.is_number?
          key = "#{e}"
        else
          key = ":#{e}"
        end
        depth << "[#{key}]"

        # figure out the correct type to push
        type = {}
        type = [] if e.is_plural?

        # evaluate this stage
        eval "collection#{depth} = #{type}"
      end

      collection
    end

    def inspect
      "#<#{self.class.name}:#{object_id} path=#{@path}>"
    end
  end
end
