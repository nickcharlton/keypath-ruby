# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'StringExtensions' do
  it 'can create a KeyPath instance from itself' do
    example_string = 'item.url'

    example_string.to_keypath.wont_be_nil
    example_string.to_keypath.must_be_kind_of KeyPath::Path

    # around and around we go
    example_string.to_keypath.to_s.must_equal example_string
  end
end
