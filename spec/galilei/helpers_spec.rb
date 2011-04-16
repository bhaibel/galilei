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
  
  describe "#words" do
    it 'generates text' do
      tester.words.should be_an_instance_of(String)
    end
    
    it 'generates a specific number of words when given a specific number' do
      tester.words(3).split(' ').length.should == 3
    end
    
    it 'generates a random number of words when given a range (but a number within the range)' do
      different_numbers = false
      seed_number = tester.words(1..20).split(' ').length
      10.times do
        x = tester.words(1..20).split(' ').length
        if !different_numbers && x != seed_number
          different_numbers = true
        end
        x.should be <= 20
        x.should be >= 1
      end
      different_numbers.should be_true
    end
  end
  
  shared_examples_for "any text-generating method" do
    it 'determines the correct range when passed a symbol'
    it 'randomly selects a count within a range when passed a range'
    it 'generates text'
  end
end