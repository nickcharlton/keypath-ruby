# test helpers
require File.expand_path 'spec_helper.rb', __dir__

# the files we're specifically testing
require File.expand_path '../lib/key_path/key_path.rb', __dir__

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
