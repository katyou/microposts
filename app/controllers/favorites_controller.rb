class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        current_user.favorite(params[:favorited_id])
        redirect_to root_url
        #@micropost = Micropost.find(params[:favorited_id])
        #current_user.favorite(@micropost)
    end
    
    def destroy
        @favorite = current_user.favorites.find_by(id: params[:id])
        @favorite.destroy
        redirect_to root_url
    end
end
