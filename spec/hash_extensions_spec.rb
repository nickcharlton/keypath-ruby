# test helpers
require File.expand_path 'spec_helper.rb', __dir__

describe 'HashExtensions' do
  it 'adds methods to the Hash class' do
    hash = {:id => 1}

    hash.must_respond_to 'keypaths_for_nested_key'
  end

  it 'can find keys in a nested hash' do
    data = {
      :id => 1,
      :item => {
        :id => 2,
        :name => 'an item'
      }
    }
    
    keypaths = data.keypaths_for_nested_key(:id)

    keypaths.wont_be_nil
    keypaths.must_include 'id'
    keypaths.must_include 'item.id'
  end

  it 'can find keys in nested array' do
    data = {
      :id => 1,
      :items => [{
        :id => 2,
        :name => 'an item'
      },
      {
        :id => 3,
        :name => 'another item'
      }]
    }

    keypaths = data.keypaths_for_nested_key(:id)

    keypaths.wont_be_nil
    keypaths.must_include 'id'
    keypaths.must_include 'items.0.id'
    keypaths.must_include 'items.1.id'
  end

  it 'can handle walking into an otherwise unknown object' do
    class ExampleClass
      def initialize
        @name = 'Example Class'
      end

      example = ExampleClass.new

      data = {:items => example}

      keypaths = data.keypaths_for_nested_key(:items)

      keypaths.wont_be_nil
      keypaths.must_include 'items'
    end
  end
end
