class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: [:twitter]

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
    unless self == other_user
    self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end


protected
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(name: auth.info.name,
                         email: User.dumy_email(auth),
                         provider: auth.provider,
                         uid: auth.uid,
                         password: Devise.friendly_token[0, 20],
                         remote_image_url: auth.info.image.gsub('http', 'https') #carrerwave用の変更
                         )
    end
    user
  end

  private

  def self.dumy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com" #POINT
  end
end
