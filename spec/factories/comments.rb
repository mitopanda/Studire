FactoryBot.define do
  factory :comment do
    content { "コメント" }
    association :user
    association :post
  end
end
