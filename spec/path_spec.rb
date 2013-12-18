# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'KeyPath::Path main methods' do
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

describe 'KeyPath::Path collections generation' do
  it 'returns an empty hash with an empty path' do
    path = KeyPath::Path.new('')
    path.to_collection.must_equal({})
  end

  it 'returns a nested hash for a single path unit' do
    path = KeyPath::Path.new('item')
    path.to_collection.must_equal({:item => {}})
  end

  it 'returns a nested array when the key is plural' do
    path = KeyPath::Path.new('items')
    path.to_collection.must_equal({:items => []})
  end

  it 'returns a double nested array with a two set keypath' do
    path = KeyPath::Path.new('item.id')
    path.to_collection.must_equal({:item => {:id => {}}})
  end

  it 'returns a nested array with an item' do
    path = KeyPath::Path.new('items.0.id')
    path.to_collection.must_equal({:items => [{:id => {}}]})
  end
end

