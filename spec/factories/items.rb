FactoryBot.define do
  factory :item do
    item_name { Faker::Team.name }
    caption { Faker::Lorem.sentence }
    category_id        { 2 }
    condition_id       { 2 }
    shipping_cost_id   { 2 }
    prefecture_id      { 2 }
    shipping_day_id    { 2 }
    price              { 2222 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
