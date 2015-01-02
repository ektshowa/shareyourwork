class AddArticleRefToCommentmicroposts < ActiveRecord::Migration
  def change
    add_reference :commentmicroposts, :article, index: true
  end
end
