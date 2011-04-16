require 'spec_helper'

class TestClass
  include Galilei::Helpers
end

describe Galilei::Helpers do
  let(:tester) { TestClass.new }
  
  it 'tests unknown methods to see if Faker responds to them' do
    Faker.constants.each do |const_name|
      const = Faker.const_get(const_name)
      if const.is_a? Class # we don't care about VERSION
        const.should_receive(:some_random_undefined_method_name)
      end
    end
    
    tester.some_random_undefined_method_name
  end
  
  def abstract_random_test(method_name, min = 1, max = 20, symbol = nil)
    param = symbol || (min..max)
    different_numbers = false
    seed_number = tester.send(method_name, param).split(' ').length
    ((max - min) * 2).times do
      x = tester.send(method_name, param).split(' ').length
      if !different_numbers && x != seed_number
        different_numbers = true
      end
      x.should be <= max
      x.should be >= min
    end
    different_numbers.should be_true
  end
  
  describe "#words" do
    it 'generates text' do
      tester.words.should be_an_instance_of(String)
    end
    
    it 'generates a specific number of words when given a specific number' do
      tester.words(3).split(' ').length.should == 3
    end
    
    it 'generates a random number of words when given a range (but a number within the range)' do
      abstract_random_test :words
    end
    
    it 'generates between 1 and 5 words when passed :short' do
      abstract_random_test :words, 1, 5, :short
    end

    it 'generates between 6 and 12 words when passed :medium' do
      abstract_random_test :words, 6, 12, :medium
    end

    it 'generates between 13 and 22 words when passed :long' do
      abstract_random_test :words, 13, 22, :long
    end
  end
  
  shared_examples_for "any text-generating method" do
    it 'determines the correct range when passed a symbol'
    it 'randomly selects a count within a range when passed a range'
    it 'generates text'
  end
end