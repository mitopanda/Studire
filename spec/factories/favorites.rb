FactoryBot.define do
  factory :favorite do
    association :post
    user { post.user }
  end
end
