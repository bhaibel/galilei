module Galilei
  module Helpers
    def paragraphs(*args)
      length = args.shift
      options = args.empty? ? {} : args.shift
      generic(:paragraphs, length, options.merge({
        :separator => '</p><p>',
        :begin => '<p>',
        :end => '</p>'}))
    end
        
    def method_missing(method_name, *args)
      generic(method_name, args.shift, (args.empty? ? {} : args.shift))
    end
    
  private
    def generic(method_name, length, options = {})
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
      if length.is_a? Range
        length = rand(length.last - length.first) + length.first
      end
      
      separator = options[:separator] || ' '
      Faker.constants.each do |faker_name|
        faker = Faker.const_get(faker_name)
        if faker.respond_to? method_name
          if length
            return add_whitespace_if_array(faker.send(method_name, length), separator)
          else
            return add_whitespace_if_array(faker.send(method_name), separator)
          end
        end
      end
    end 
    
    def add_whitespace_if_array(possible_array, separator = ' ')
      possible_array.is_a?(Array) ? possible_array.join(separator) : possible_array
    end
  end
end