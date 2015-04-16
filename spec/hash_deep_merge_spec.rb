# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'HashDeepMerge' do
  it 'adds methods to the Hash class' do
    hash = { id: 1 }

    hash.must_respond_to 'deep_merge'
    hash.must_respond_to 'deep_merge!'
  end

  it 'recursively adds two hashes' do
    one = { one: { id: 1 } }
    two = { one: { url: 'https://nickcharlton.net' } }
    three = { one: { id: 1, url: 'https://nickcharlton.net' } }

    output = one.deep_merge(two)

    output.must_be_kind_of Hash
    output.must_equal three
  end

  it 'recursively adds two hashes in place' do
    one = { one: { id: 1 } }
    two = { one: { url: 'https://nickcharlton.net' } }
    three = { one: { id: 1, url: 'https://nickcharlton.net' } }

    one.deep_merge!(two)

    one.must_be_kind_of Hash
    one.must_equal three
  end
end

describe 'HashNormalMerge' do
  it 'combines nested hashes without decending into them' do
    one = { 'a' => 100, 'b' => 200, 'c' => { 'c1' => 12, 'c2' => 14 } }
    two = { 'b' => 254, 'c' => 300, 'c' => { 'c1' => 16, 'c3' => 94 } }
    expected = { 'a' => 100, 'b' => 254, 'c' => { 'c1' => 16, 'c3' => 94 } }

    output = one.merge(two)

    output.must_be_kind_of Hash
    output.must_equal expected
  end

  it 'combines nested hashes without decending into them in place' do
    one = { 'a' => 100, 'b' => 200, 'c' => { 'c1' => 12, 'c2' => 14 } }
    two = { 'b' => 254, 'c' => 300, 'c' => { 'c1' => 16, 'c3' => 94 } }
    expected = { 'a' => 100, 'b' => 254, 'c' => { 'c1' => 16, 'c3' => 94 } }

    one.merge!(two)

    one.must_be_kind_of Hash
    one.must_equal expected
  end
end
