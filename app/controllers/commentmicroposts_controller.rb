class CommentmicropostsController < ApplicationController
  def create
    #@micropost = Micropost.find_by(id: params["micropost_id_#{@micropost.id}"])
    #@commentmicropost = @micropost.commentmicroposts.build(params[:commentmicropost])
    #@commentmicropost.user_id = current_user.id
    
    #@commentmicropost = Commentmicropost.new(commentmicropost_params)
    #@commentmicropost = Commentmicropost.new(:content => params["content_#{@micropost.id}"], :user_id => params["user_id_#{@micropost.id}"])
   
    @commentmicropost = Commentmicropost.new(commentmicropost_params)
    #@commentmicropost.content = params["content_#{@micropost.id}"]
    #@commentmicropost.user_id = params["user_id_#{@micropost.id}"]
    #@commentmicropost.micropost_id = params["micropost_id_#{@micropost.id}"]
       
    respond_to do |format|
      if @commentmicropost.save
        format.html { redirect_to current_user }
        format.json { render :json => @commentmicropost }
      end
    end
    
    #postsNumber = Commentmicropost.where(:micropost_id => @micropost.id).count
  end
  
  def new
    @micropost = Micropost.find_by(id: params[:micropostID])
    @commentmicropost = @micropost.commentmicroposts.build
    @userID = current_user.id
    
    respond_to do |format|
      format.html  
      format.js {}
      
    end
    #@commentmicropost = Commentmicropost.new 
  end
  
  private
  
  def commentmicropost_params
    params.require(:commentmicropost).permit(:content, :micropost_id, :user_id)
  end
end
