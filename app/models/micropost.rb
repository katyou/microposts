class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  
  has_many :favoriting_favorites, class_name: "Favorite",
                                  foreign_key: "favorite_id",
                                  dependent: :destroy
  has_many :favoriting_microposts, through: :favoriting_favorites, source: :favorited
  #has_many :favorited_favorites, class_name: "Favorite",
   #                              foreign_key: "favorited_id",
    #                             dependent: :destroy
  #has_many :favorited_microposts, through: :favorited_favorites, source: :favorite
  
end