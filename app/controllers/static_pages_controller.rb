class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      
      @favorite = current_user.favorites.build
      @favorite_items = current_user.favorite_microposts
    end
  end
end
