include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :captured_image do
    content    { fixture_file_upload("spec/fixtures/img/TECHCAMP.png", 'image/png') }
    prototype

    trait :main_image do
      status 0
    end

    trait :sub_image do
      status 1
    end
  end

end
