module KeyPath
  class Path
    def initialize(path='')
      @path = path
    end

    def parent
      s = self.to_a
      s.pop

      # there's no parent if it's empty
      if s == []
        return nil
      end

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
      s = self.to_a
      depth = ''

      s.each_with_index do |e, i|
        # assemble the key
        if e.is_number?
          key = "#{e}"
        else
          key = ":#{e}"
        end
        depth << "[#{key}]"

        # figure out the correct type to push
        type = {}
        if e.is_plural?
          type = []
        end

        # evaluate this stage
        eval "collection#{depth} = #{type}"
      end

      collection
    end

    def inspect
      "#<#{self.class.name}:#{self.object_id} path=#{@path}>"
    end
  end
end
