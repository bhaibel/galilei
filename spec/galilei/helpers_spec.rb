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
        const.should_receive(:respond_to?).with(:some_random_undefined_method_name)
      end
    end
    
    tester.some_random_undefined_method_name
  end
  
  def abstract_random_test(method_name, options = {})
    options = {
      :min => 1,
      :max => 20,
      :delimiter => ' '
    }.merge options
    param = options[:symbol] || (options[:min]..options[:max])
    different_numbers = false
    seed_number = tester.send(method_name, param).split(options[:delimiter]).length
    ((options[:max] - options[:min]) * 2).times do
      y = tester.send(method_name, param).split(options[:delimiter])
      #raise y.inspect
      x = y.length
      if !different_numbers && x != seed_number
        different_numbers = true
      end
      x.should be <= options[:max]
      x.should be >= options[:min]
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
      abstract_random_test :words, :min => 1, :max => 5, :symbol => :short
    end

    it 'generates between 6 and 12 words when passed :medium' do
      abstract_random_test :words, :min => 6, :max => 12, :symbol => :medium
    end

    it 'generates between 13 and 22 words when passed :long' do
      abstract_random_test :words, :min => 13, :max => 22, :symbol => :long
    end
  end

  describe "#paragraphs" do
    it 'generates text' do
      tester.paragraphs.should be_an_instance_of(String)
    end
    
      it 'generates a random number of paragraphs when given a range (but a number within the range)' do
        abstract_random_test :paragraphs, :delimiter => '</p><p>'
      end

      it 'generates between 1 and 5 paragraphs when passed :short' do
        abstract_random_test :paragraphs, :min => 1, :max => 5, :symbol => :short, :delimiter => '</p><p>'
      end

      it 'generates between 6 and 12 paragraphs when passed :medium' do
        abstract_random_test :paragraphs, :min => 6, :max => 12, :symbol => :medium, :delimiter => '</p><p>'
      end

      it 'generates between 13 and 22 paragraphs when passed :long' do
        abstract_random_test :paragraphs, :min => 13, :max => 22, :symbol => :long, :delimiter => '</p><p>'
      end
    end
  
  shared_examples_for "any text-generating method" do
    it 'determines the correct range when passed a symbol'
    it 'randomly selects a count within a range when passed a range'
    it 'generates text'
  end
end