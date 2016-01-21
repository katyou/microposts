module SessionsHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
       !!current_user
    end
    
    def store_location
       session[:forwarding_url] = request.url if request.get?
    end
    
    #def current_micropost
       # @current_micropost ||= Micropost.find_by(id: session[:micropost_id])
    #end
end