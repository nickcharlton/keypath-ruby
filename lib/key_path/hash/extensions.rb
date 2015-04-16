module KeyPath
  # A Mixin for Hash which allows us to create a path from a key.
  module HashExtensions
    def keypaths_for_nested_key(nested_key = '', nested_hash = self,
                                path = [], all_values = {})
      nested_hash.each do |k, v|
        path << k.to_s # assemble the path from the key
        case v
        when Array then
          v.each_with_index do |item, i|
            path << "#{i}" # add the array key
            keypaths_for_nested_key(nested_key, item, path, all_values)
          end
          path.pop # remove the array key
        when Hash then keypaths_for_nested_key(nested_key, v, path, all_values)
        else
          all_values.merge!("#{path.join('.')}" => "#{v}") if k == nested_key

          path.pop
        end
      end
      path.pop

      all_values
    end
  end
end

# Mix `HashExtensions` into `Hash`.
class Hash
  include KeyPath::HashExtensions
end
