module Galilei
  module Helpers
    def method_missing(method_name, *args)
      length = args.shift
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