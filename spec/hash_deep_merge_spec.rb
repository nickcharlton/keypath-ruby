# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'HashDeepMerge' do
  it 'adds methods to the Hash class' do
    hash = {:id => 1}

    hash.must_respond_to 'deep_merge'
    hash.must_respond_to 'deep_merge!'
  end

  it 'recursively adds two hashes' do
    one = {:one => {:id => 1}}
    two = {:one => {:url => 'http://nickcharlton.net'}}
    three = {:one => {:id => 1, :url => 'http://nickcharlton.net'}}

    output = one.deep_merge(two)

    output.must_be_kind_of Hash
    output.must_equal three
  end

  it 'recursively adds two hashes in place' do
    one = {:one => {:id => 1}}
    two = {:one => {:url => 'http://nickcharlton.net'}}
    three = {:one => {:id => 1, :url => 'http://nickcharlton.net'}}

    one.deep_merge!(two)

    one.must_be_kind_of Hash
    one.must_equal three
  end
end
