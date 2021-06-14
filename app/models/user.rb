class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:twitter]
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_many :cafeposts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :cafepost, dependent: :destroy
  
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
  
  def feed_cafeposts
    Cafepost.where(user_id: self.following_ids + [self.id])
  end
  
  def favorite(cafepost)
    self.favorites.find_or_create_by(cafepost_id: cafepost.id)
  end

  def unfavorite(cafepost)
    favorite = self.favorites.find_by(cafepost_id: cafepost.id)
    favorite.destroy if favorite
  end
  
  def favorite?(cafepost)
    self.likes.include?(cafepost)
  end
  
  def remember_me
    true
  end
  
  def self.from_omniauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

     unless user
       user = User.create(
         uid:      auth.uid,
         provider: auth.provider,
         email:    User.dummy_email(auth),
         password: Devise.friendly_token[0, 20],
         name: auth.info.name
         )
     end
  
     user
  end
  
  private
  
  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end
end
