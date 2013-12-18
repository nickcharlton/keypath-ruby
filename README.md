# keypath-based collection access extensions for Ruby.

This gem allows you to access nested Ruby collections (`Hash`, `Array`, etc) using 
keypaths.

For example, say you had a nested data structure like:

```ruby
data = {
    :item_one => {:id => 1, :url => 'http://nickcharlton.net/},
    :something_else => [
        {
            :id => 1,
            :url => 'https://github.com/'
        }
    ]
}
```

You could access 'https://github.com/' through: `something_else.0.url`. Basically, 
this is intended to allow you to manipulate/transform large nested structures that 
you might get back from a JSON document.

## Installation

Add this line to your application's Gemfile:

    gem 'keypath'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keypath

## Usage

`KeyPath` is at least two things. First, it's a class (actually, `KeyPath::Path`)
which represents a path (this is just a string, and has methods to go back and
forth from it) and secondly a set of class extensions for `Enumerable`, `Hash` and 
`String` which allow you to use the native collection classes with keypaths.

```ruby
require 'key_path'

data = {
    :item => {
        :url => 'http://nickcharlton.net'
    }
}

# fetching a path
path = KeyPath::Path.new 'item.url'
data.value_at_keypath(path) #=> 'http://nickcharlton.net'

# finding all `:url` paths in a collection
data.keypaths_for_nested_key(:url) #=> {item.url => 'http://nickcharlton.net'}

# going back and forth from a string
path.to_s #=> 'item.url'
'item.url'.to_keypath #=> #<KeyPath:70096895112220 path=item.url>

# get the parent of a keypath (or nil, if there isn't one)
path.parent #=> #<KeyPath:70096895221110 path=item>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

Copyright (c) 2013 Nick Charlton (<nick@nickcharlton.net>)

