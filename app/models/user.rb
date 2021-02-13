class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # attr_accessor :remember_token
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
  
  # ランダムなトークンを返す
  #def self.new_token
    #SecureRandom.urlsafe_base64
  #end
  
  # 与えられた文字列のハッシュ値を返す
  #def self.digest(string) #User.digest(string)を同じ意味
    #cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  #BCrypt::Engine.cost
    #BCrypt::Password.create(string, cost: cost)
  #end
  
  # 永続的セッションで使用するユーザーをデータベースに記憶する
  #def remember
    #self.remember_token = User.new_token
    #update_attribute(:remember_digest, User.digest(remember_token))
  #end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  #def authenticated?(remember_token)
    #return false if remember_digest.nil?
    #BCrypt::Password.new(remember_digest).is_password?(remember_token)
  #end
  
  #def forget
    #validationを無視して更新（:remember_digestの値をnilに）
    #update_attribute(:remember_digest, nil)
  #end
  
  def remember_me
    true
  end
end
