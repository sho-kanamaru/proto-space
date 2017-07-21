FactoryGirl.define do

  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password }
    password_confirmation { password }
    group                 { Faker::Lorem.sentence }
    profile               { Faker::Lorem.sentence }
    works                 { Faker::Lorem.sentence }
  end

end
