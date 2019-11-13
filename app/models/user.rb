class User < ApplicationRecord
  has_many :feeds
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ProfileimageUploader
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :introduce, length: { maximum: 255 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

end
