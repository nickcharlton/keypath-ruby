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
      s = self.to_a
    
      {:item => {
         :resource_uri => {}
      }}
    end

    def inspect
      "#<#{self.class.name}:#{self.object_id} path=#{@path}>"
    end
  end
end
