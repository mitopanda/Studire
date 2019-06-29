class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: [:twitter]

  validates :profile, length: { maximum: 200 }
  validates :name, presence: true, length: { maximum: 50 }
  has_many :posts, dependent: :destroy
  has_many :comments

  # carrierwave
  mount_uploader :image, ImagesUploader

  # relationships
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  # favorites
  has_many :favorites, dependent: :destroy
  has_many :liked_posts, through: :favorites, source: :post

  def like(post)
    favorites.find_or_create_by(post_id: post.id)
  end

  def unlike(post)
    favorites = self.favorites.find_by(post_id: post.id)
    favorites&.destroy
  end

  def liking?(post)
    liked_posts.include?(post)
  end

  protected

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(name: auth.info.name,
                         email: User.dumy_email(auth),
                         provider: auth.provider,
                         uid: auth.uid,
                         password: Devise.friendly_token[0, 20],
                         remote_image_url: auth.info.image.gsub('http', 'https'))
    user
  end

  private

  def self.dumy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
