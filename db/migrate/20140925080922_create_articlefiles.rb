class CreateArticlefiles < ActiveRecord::Migration
  def change
    create_table :articlefiles do |t|
      t.string :filename
      t.string :filetype
      t.binary :filecontents
      t.integer :article_id

      t.timestamps
    end
  end
end
