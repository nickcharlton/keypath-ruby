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

  it 'can make a set of strings plural' do
    %w(word rail dress business).each do |v|
      v.is_plural?.must_equal false
    end

    %w(words rails dresses businesses).each do |v|
      v.is_plural?.must_equal true
    end
  end

  it 'can make a set of string singular' do
    %w(word rail dress business).each do |v|
      v.is_singular?.must_equal true
    end

    %w(words rails dresses businesses).each do |v|
      v.is_singular?.must_equal false
    end
  end

  it 'can test if a string is actually a number' do
    '0'.is_number?.must_equal true
    '1234567890'.is_number?.must_equal true

    'item'.is_number?.must_equal false
  end
end
