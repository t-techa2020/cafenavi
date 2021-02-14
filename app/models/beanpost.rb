class Beanpost < ApplicationRecord
  belongs_to :owner
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :amount, presence: true, numericality: true
  validates :price, presence: true, numericality: true
  validates :country, presence: true, length: { maximum: 255 }

end
