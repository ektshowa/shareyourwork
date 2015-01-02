class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy 
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @feed_items = current_user.feed.paginate(page: params[:page])
    
    # Get the user's microposts to be displayed
    @user = User.find(params[:id])
    @microposts = @user.microposts.order("created_at DESC").paginate(page: params[:page], :per_page => 5)
    
    # current_user and id following articles
    @currentUserArticles = current_user.articles.order("created_at DESC")
    sqlquery = "SELECT a.title as title, u.name as name, a.description as description, a.created_at as created_at
                FROM articles a JOIN users u ON u.id = a.user_id
                WHERE a.user_id IN 
                                (SELECT followed_id 
                                 FROM relationships
                                 WHERE follower_id = :userID AND followed_id <> :userID)"
    @followedArticles = Article.find_by_sql([sqlquery, {:userID => current_user.id}])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the YShare Space!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Account updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
