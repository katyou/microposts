class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
        end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micopost deleted"
        redirect_to request.referrer || root_url
    end
    
    #お気に入りに追加したもの
    #def favorite
       # @micropost = Micropost.find(params[:id])
       # @microposts = @micropost.favorite.contents #@userがお気に入りしている投稿内容
        #@users = @microposts.microposts.order(created_at: :desc)
    #end
    
    private
    
    def micropost_params
        params.require(:micropost).permit(:content)
    end
end
