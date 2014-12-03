class ArticlesController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :create, :destroy]
  before_filter :correct_user, only: [:edit, :destroy]
  
  def create
    @article = current_user.articles.build(article_params)
    
    #if @article.save
    #if ! @article.nil?
    #  @article.save
    #  flash[:success] = "You successfully saved your article!"
    #  redirect_to root_url
    #else
    #  render 'new'  
    #end
    
    respond_to do |format|
      if !@article.nil?
        if @article.save
           
           # saved article metadata 
                  #flash[:success] = "You successfully saved your article's information!"
           #Get the hash with encrypted user_id and article_id for last
           encrypted_data = current_user_article @article
           if encrypted_data.nil?
             #@thedata = "encrypted_data" 
           else
             #encrypt_user_id    = @thecrypt.encrypt_and_sign(@article.user_id)
             @article_data = encrypted_data
           end
           format.js 
        end
      end
    end
    
  end
  
  def correct_user
    @article = current_user.articles.find_by_id(params[:id])
    redirect_to root_url if @article.nil?
  end
  
  def new
    @article = current_user.articles.build
  end
  
  private
  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
  
  def article_params
    params.require(:article).permit(:title, :subtitle, :subject, :description, :language, :format, :region,
                                    :isbn, :articlecontent, :datepublished)
  end
  
  def current_user_article(theSavedArticle)
    
    # Encrypt user_id and article_id
    encrypt_user_id    = getMessageEncryptor(theSavedArticle.user_id)
    encrypt_article_id = getMessageEncryptor(theSavedArticle.id)
    
    # Return the hash
    user_article = {"user_id" => encrypt_user_id, "article_id" => encrypt_article_id}
  end
  
  def getMessageEncryptor(data_to_encrypt)
      salt  = SecureRandom.random_bytes(64)
      key   = ActiveSupport::KeyGenerator.new('password').generate_key(salt)
      crypt = ActiveSupport::MessageEncryptor.new(key)                       # => #<ActiveSupport::MessageEncryptor ...>
      encrypted_data = crypt.encrypt_and_sign(data_to_encrypt)              # => "NlFBTTMwOUV5UlA1QlNEN2xkY2d6eThYWWh..."
      decrypted = crypt.decrypt_and_verify(encrypted_data)  
  end
end
