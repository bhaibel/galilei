require 'spec_helper'

describe Galilei::Helpers do
  it 'tests unknown methods to see if Faker responds to them' do
    pending "yes, RSpec, I know 'some_random_undefined_method_name' is undefined. That's the *point.*"
    Faker.constants.each do |const_name|
      const = Faker.const_get(const_name)
      if const.is_a? Class # we don't care about VERSION
        const.should_receive(:some_random_undefined_method_name)
      end
    end
    
    Galilei::Helpers.send :some_random_undefined_method_name
  end
  
  shared_examples_for "any text-generating method" do
    it 'determines the correct range when passed a symbol'
    it 'randomly selects a count within a range when passed a range'
    it 'generates text'
  end
end