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
end
