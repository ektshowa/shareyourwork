class ArticlefilesController < ApplicationController
  
  def create
    @article = Article.find_by(params[:article_id])
    @articlefile = Articlefile.new(articlefile_params)
    
    respond_to do |format|
      if @articlefile.save
        format.html { redirect_to uploadarticle_path }
        format.js
      end
    end
  end
  
  def new
    @article = Article.find_by(id: params[:article_id])
    @articlefile = @article.articlefiles.build
  end
  
  
  private
  
  def articlefile_params
     params.require(:articlefile).permit(:filecontents,:article_id)
  end
end
