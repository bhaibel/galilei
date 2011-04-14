module Galilei
  module Helpers
    def method_missing(method_name, *args)
      length = args.shift
      
      # length can be a symbol, a range, an integer, or a fixnum. In the former two cases we need to convert it to something faker can use.
      
      # so first we translate symbols to ranges
      length = case length
      when :short
        (1..5)
      when :medium
        (6..12)
      when :long
        (13..22)
      else
        length
      end
      
      #then we translate ranges to actual numbers
      if length.class == Range
        length = rand(length.last - length.first) + length.first
      end
      
      Faker.constants.each do |faker_name|
        faker = Faker.const_get(faker_name)
        if faker.respond_to? method_name
          if length
            return faker.send method_name, length
          else
            return faker.send method_name
          end
        end
      end
    end
  end
end