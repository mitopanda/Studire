FactoryBot.define do
  factory :favorite do
    post
    user { post.user } 
  end
end
