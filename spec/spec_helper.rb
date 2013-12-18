# test coverage
require 'coveralls'

# enable coveralls
Coveralls.wear!

# test framework
require 'minitest/autorun'
require 'minitest/pride'

# pull in the library
require File.expand_path '../lib/key_path.rb', __dir__

