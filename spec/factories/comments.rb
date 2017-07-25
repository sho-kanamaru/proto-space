FactoryGirl.define do

  factory :comment do
    content       { Faker::Lorem.sentence }
    prototype
    user
  end

end
