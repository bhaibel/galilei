module Galilei
  module Helpers
    #as a first step, let's just pass directly in to Faker
    def method_missing(method_name)
      [
        Faker::Address,
        Faker::Company,
        Faker::Internet,
        Faker::Lorem,
        Faker::Name,
        Faker::PhoneNumber
      ].each do |faker|
        if faker.respond_to? method_name
          return faker.send method_name
        end
      end
    end
  end
end