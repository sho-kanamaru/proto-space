FactoryGirl.define do

  factory :prototype do
    title         { Faker::StarWars.planet }
    catch_copy    { Faker::Lorem.sentence }
    concept       { Faker::Lorem.sentence }
    likes_count   { Faker::Number.between(1, 30) }
    created_at    { Faker::Time.between(2.days.ago, Time.now, :all) }
    user

    after(:create) do |prototype|
      create(:captured_image, :main_image, prototype: prototype)
      create(:captured_image, :sub_image, prototype: prototype)
    end
  end

end
