# test helpers
require File.expand_path "spec_helper.rb", __dir__

describe "EnumerableExtensions" do
  it "adds methods to collections" do
    hash = { id: 1 }

    hash.must_respond_to "value_at_keypath"
    hash.must_respond_to "set_keypath"
  end

  it "can fetch simple path values" do
    hash = { id: 1 }

    hash.value_at_keypath("id").must_equal 1
  end

  it "can accept KeyPath::Path objects for keypaths" do
    hash = { id: 1 }
    keypath = KeyPath::Path.new("id")

    hash.value_at_keypath(keypath).must_equal 1
  end

  it "can fetch with a nested hash key path" do
    hash = { item: { id: 1 } }

    hash.value_at_keypath("item.id").must_equal 1
  end

  it "can fetch a nested array object" do
    hash = { items: [{ id: 1 }] }

    hash.value_at_keypath("items.0").must_equal(id: 1)
  end

  it "can set a simple value using a keypath string" do
    source = { item: { id: {} } }
    keypath = "item.id"
    value = 1

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it "can set a simple value using a KeyPath::Path object" do
    source = { item: { id: {} } }
    keypath = KeyPath::Path.new("item.id")
    value = 1

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it "can set a string value using a KeyPath::Path object" do
    source = { item: { id: {} } }
    keypath = KeyPath::Path.new("item.id")
    value = "value"

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it "can set a string with capital letters" do
    source = { item: { id: {} } }
    keypath = KeyPath::Path.new("item.id")
    value = "VALUE"

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it "can set a hash for a path" do
    source = { item: { id: {} } }
    keypath = KeyPath::Path.new("item")
    value = { id: 1 }

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it "can set a value in a nested array" do
    source = { items: [{ id: 1 }] }
    keypath = KeyPath::Path.new("items.1")
    value = { id: 2 }

    source.set_keypath(keypath, value)

    source.value_at_keypath(keypath).must_equal(value)
  end

  it "can delete a value in a hash" do
    source = { id: 1, metadata: { name: "test", value: "v" } }

    expected = { id: 1, metadata: { value: "v" } }
    source.delete_at_keypath("metadata.name")
    _(source).must_equal(expected)

    source.delete_at_keypath("id")
    _(source).must_equal({ metadata: { value: "v" } })
  end

  it "can delete by path with array index" do
    source = { items: [{ id: 1 }, { id: 2 }, { id: 3 }] }
    expected = { items: [{ id: 1 }, { id: 3 }] }
    source.delete_at_keypath("items.1")
    _(source).must_equal(expected)
  end

  it "can delete by each path if the matched is an array of elements" do
    source = { items: [{ metadata: { name: "n1", value: "v1" } },
                       { metadata: { name: "n2", value: "v2" } }, { metadata: { name: "n3", value: "v3" } }] }
    expected = { items: [{ metadata: { name: "n1" } }, { metadata: { name: "n2" } },
                         { metadata: { name: "n3" } }] }
    source.delete_at_keypath("items.metadata.value")
    _(source).must_equal(expected)
  end

  it "can untouch the hash when keypath is not matching anything" do
    source = { items: [{ id: 1 }, { id: 2 }, { id: 3 }] }
    expected = { items: [{ id: 1 }, { id: 2 }, { id: 3 }] }
    source.delete_at_keypath("items.metadata.value")
    _(source).must_equal(expected)

    source = [1, 2, 3]
    expected = [1, 2, 3]
    source.delete_at_keypath("items.metadata.value")
    source.delete_at_keypath("items")
    source.delete_at_keypath("20")
    _(source).must_equal(expected)
  end

  it "can delete by path with wildcard as hash index" do
    source = { items: { year2007: { price: 1, id: 1 },
                        year2015: { price: 2, id: 2 } } }
    expected = { items: { year2007: { id: 1 }, year2015: { id: 2 } } }
    source.delete_at_keypath_with_wildcard("items.*.price")
    _(source).must_equal(expected)
  end
end
