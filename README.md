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

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

Copyright (c) 2013 Nick Charlton (<nick@nickcharlton.net>)

