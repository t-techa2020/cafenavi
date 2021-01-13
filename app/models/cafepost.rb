class Cafepost < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :image, presence: true
  #画像のバリデーションを追加
  
  has_many :favorites, dependent: :destroy
  has_many :liked, through: :favorites, source: :user
  
end
