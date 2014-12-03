class RemoveArticlefilenameFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :articlefilename, :string
  end
end
