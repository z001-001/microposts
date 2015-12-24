class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  has_many :favorites, class_name:  "Favorite",
                       foreign_key: "micropost_id",
                       dependent:   :destroy
  has_many :favorite_users, through: :favorites, source: :user

end
