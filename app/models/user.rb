class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    
    has_secure_password
    has_many :microposts
    has_many :following_relationships, class_name: "Relationship",
                                       foreign_key: "follower_id",
                                       dependent: :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    has_many :follower_relationships, class_name: "Relationship",
                                      foreign_key: "followed_id",
                                      dependent: :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    #あるユーザーがお気に入りに入れているmicropostのidたち
    has_many :favorites, dependent: :destroy
    
    #あるユーザーがお気入りに入れているmicropostのモデルをfavoritesのidたちから取得
    has_many :favorite_microposts, through: :favorites, source: :micropost
    
 
    #他のユーザーをフォローする
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    #フォローしているユーザーをアンフォローする
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    #あるユーザーをフォローしているかどうか
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    #つぶやき取得のためのメソッド
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    #お気に入り取得のためのメソッド
    def favorite_items
        Favorite.where(user_id: favorite_user_ids + [self.id])
    end
    
    
     #ほかのユーザーのメッセージをお気に入りにいれる
     def favorite(micropost)
         #favorites.find_or_create_by(micropost)
         favorites.find_or_create_by(micropost_id: micropost)
     end
     
     

     #お気に入りを解除する
     def unfavorite(micropost_id)
         favorites = favorites(micropost_id)
         favorites.destroy if favorites
     end
     
     #ある投稿をお気に入りにしているかどうか
     #user.favorite_microposts ★micropostモデルの配列
     def favoriting?(micropost)
         favorite_microposts.include?(micropost)
     end

end
