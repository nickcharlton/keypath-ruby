module KeyPath
  class Path
    def initialize(path='')
      @path = path
    end

    def parent
      s = self.to_a
      s.pop
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
