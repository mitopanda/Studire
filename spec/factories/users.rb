FactoryBot.define do
  factory :user, aliases: [:follow] do
    name { 'test' }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
