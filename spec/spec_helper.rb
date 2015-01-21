require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

# test framework
require 'minitest/autorun'
require 'minitest/pride'

# pull in the library
require File.expand_path '../lib/key_path.rb', __dir__
