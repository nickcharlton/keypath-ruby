# test helpers
require File.expand_path 'spec_helper.rb', __dir__

# the files we're specifically testing
require File.expand_path '../lib/key_path/path.rb', __dir__
require File.expand_path '../lib/string/key_path.rb', __dir__

describe 'KeyPath' do
  it 'creates a KeyPath instance from a string' do
    path = KeyPath::Path.new('item.url')

    path.wont_be_nil
    path.to_s.must_be_kind_of String
    path.to_s.must_equal 'item.url'
  end

  it 'outputs an array of items in the path' do
    path = KeyPath::Path.new('item.url')

    path.to_a.must_be_kind_of Array
    path.to_a.must_equal ['item', 'url']
  end

  it 'spits out a useful inspect string' do
    path = KeyPath::Path.new('item.url')

    path.inspect.must_be_kind_of String
    path.inspect.wont_be_nil
  end

  it 'returns a parent if one exists' do
    path = KeyPath::Path.new('item.url')

    path.parent.wont_be_nil
    path.parent.must_be_kind_of KeyPath::Path
  end

  it 'returns nil if a parent doesnt exist' do
    path = KeyPath::Path.new('item')

    path.parent.must_be_nil
  end
end

describe 'String' do
  it 'can create a KeyPath instance from itself' do
    example_string = 'item.url'

    example_string.to_keypath.wont_be_nil
    example_string.to_keypath.must_be_kind_of KeyPath::Path

    # around and around we go
    example_string.to_keypath.to_s.must_equal example_string
  end
end
