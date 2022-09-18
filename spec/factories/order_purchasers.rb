FactoryBot.define do
  factory :order_purchaser do
    post_code     { '123-4567' }
    prefecture_id { 23 }
    city          { '大阪' }
    house_number  { '1-2' }
    building      { '団地1棟' }
    phone_number  { '08012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
