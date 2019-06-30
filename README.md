# Studire
自分が学んだことと学習方法を記載し、学びのテンプレートを作成するサービスです。  
url: https://studire.com  
ログイン画面に登録不要で見れる閲覧用のテストユーザログインボタンを用意しています。  
![スクリーンショット 2019-07-01 0 39 31](https://user-images.githubusercontent.com/50113713/60398931-bbd2cf00-9b98-11e9-84fb-954d3fb43122.png)


# 使用技術
- Ruby 2.6.2
- Ruby on Rails 5.2.3
- PostgreSQL 11.2
- SCSS
- bootstrap
- jQuery(少しの使用となっています)
- Docker
- docker-compose
- AWS
  - Route53
  - Certificate Manager
  - VPC
  - EC2
  - ALB
  - ECS
  - ECR
  - RDS for PostgreSQL
  - S3
  - CloudFront
- CircleCI
  - ecs-deploy
 
# 本番環境
![AWS-Page-1](https://user-images.githubusercontent.com/50113713/60399151-5e8c4d00-9b9b-11e9-93a3-8881f5181030.png)

ECRにプッシュした本番環境用のイメージを用いて、ECSのEC2インスタンスタイプでデプロイしています。できる限り無料枠で収めたかったためForgateタイプの採用は見送っています。  
データベースにはRDSforPostgreSQLを用いています。  
画像は全てS3に保存し、CloudFrontでCDN配信を行っています。asset_syncと言うgemを用いて、app/assets以下の画像も全てCDN配信を行っています。  
ALBを用いてhttp通信ををhttpsに全てリダイレクトすることで常時SSL化を実装しています。  

# 開発環境
Docker環境での開発になります。  
また、開発時にはdocker-composeを使用しています。  
開発環境では作業ごとにブランチを切って行っています。  
また、環境変数の都合でDockerfileを開発環境用のDockerfileと本番環境用のDockerfile.prodに分けています。  

# デプロイ方法
circleCIを用いた自動デプロイを採用しています。作業用ブランチがmasterブランチにマージされた時に、Rspecによるテスト、ECRにイメージのpush、[ecs-deploy](https://github.com/silinternational/ecs-deploy)で
ECSにデプロイ、といった流れでデプロイが行われるようにしています。尚、作業用ブランチをpushした時点ではRspecによるテストまで行われます。

# 機能一覧、gem
- 記事機能(postモデル)
  - 記事機能全般
  - いいねに基づいた人気順表示
  - Ransackを用いた検索機能(新着順、人気順の両方対応)
  - acts-as-taggable-onを用いたタグ機能(新着順、人気順の両方対応)
  - rails-autolinkを用いた記事内でのリンク表示
- ユーザ機能(userモデル)
  - ユーザ登録・ログイン機能全般(devise)
  - Twitterでのログイン機能(omniauth-twitter)
  - 一覧表示機能(Ransackでの検索対応) 
  - プロフィール画像の保存機能（carrierwave,mini-magick,fog-aws）
- コメント機能(commentモデル)
  - 投稿、削除、表示
- フォロー機能(relationshipモデル)
  - フォロー、アンフォロー機能
  - フォロー中のユーザ&フォロワーの表示
- いいね機能(favoriteモデル)
  - 一覧機能
  - いいねした投稿の検索、タグ絞り込み機能(Ransack, acts-as-taggable-on)
- 管理者機能(rails_admin, cancancan)
- ページネーション機能(kaminari)

## テスト(Rspec)
  - 単体テスト(model spec)
  - 統合テスト(system spec)
  
  
  
