FactoryBot.define do
  factory :post do
    title  { "タイトル" }
    content { "学習内容" }
    book { "ノートA,サイトA" }
    direction { "具体的な学習方法" }
    summary { "まとめ" }
    association :user
  end
end
