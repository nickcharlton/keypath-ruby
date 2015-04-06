# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'EnumerableExtensions' do
  it 'adds methods to collections' do
    hash = {:id => 1}

    hash.must_respond_to 'value_at_keypath'
    hash.must_respond_to 'set_keypath'
  end

  it 'can fetch simple path values' do
    hash = {:id => 1}

    hash.value_at_keypath('id').must_equal 1
  end

  it 'can accept KeyPath::Path objects for keypaths' do
    hash = {:id => 1}
    keypath = KeyPath::Path.new('id')

    hash.value_at_keypath(keypath).must_equal 1
  end


  it 'can fetch with a nested hash key path' do
    hash = {:item => {:id => 1}}

    hash.value_at_keypath('item.id').must_equal 1
  end

  it 'can fetch a nested array object' do
    hash = {:items => [{:id => 1}]}

    hash.value_at_keypath('items.0').must_equal({:id => 1})
  end

  it 'can set a simple value using a keypath string' do
    source = {:item => {:id => {}}}
    keypath = 'item.id'
    value = 1

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it 'can set a simple value using a KeyPath::Path object' do
    source = {:item => {:id => {}}}
    keypath = KeyPath::Path.new('item.id')
    value = 1

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it 'can set a string value using a KeyPath::Path object' do
    source = {:item => {:id => {}}}
    keypath = KeyPath::Path.new('item.id')
    value = 'value'

    source.set_keypath(keypath, value)
    
    source.value_at_keypath(keypath).must_equal(value)
  end
  
  
  it 'can set a string with capital letters' do
    source = {:item => {:id => {}}}
    keypath = KeyPath::Path.new('item.id')
    value = 'VALUE'

    source.set_keypath(keypath, value)
    
    source.value_at_keypath(keypath).must_equal(value)
  end
  
  
  it 'can set a hash for a path' do
    source = {:item => {:id => {}}}
    keypath = KeyPath::Path.new('item')
    value = {:id => 1}

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it 'can set a value in a nested array' do
    source = {:items => [{:id => 1}]}
    keypath = KeyPath::Path.new('items.1')
    value = {:id => 2}

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end
end
