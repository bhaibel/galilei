module Galilei
  module Helpers
    def method_missing(method_name)
      Faker.constants.each do |faker_name|
        faker = Faker.const_get(faker_name)
        if faker.respond_to? method_name
          return faker.send method_name
        end
      end
    end
  end
end