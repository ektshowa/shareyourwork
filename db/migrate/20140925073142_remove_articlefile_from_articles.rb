class RemoveArticlefileFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :articlefile, :binary
  end
end
