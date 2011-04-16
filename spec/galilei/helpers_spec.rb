require 'spec_helper'

describe Galilei::Helpers do
  it 'tests unknown methods to see if Faker responds to them'
  
  shared_examples_for "any text-generating method" do
    it 'determines the correct range when passed a symbol'
    it 'randomly selects a count within a range when passed a range'
    it 'generates text'
  end
end