class AddHasfileToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :hasfile, :boolean
  end
end
