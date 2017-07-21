FactoryGirl.define do

  factory :captured_image do
    content       File.open("#{Rails.root}/public/images/TECHCAMP.png")
    prototype

    trait :main_image do
      status 0
    end

    trait :sub_image do
      status 1
    end
  end

end
