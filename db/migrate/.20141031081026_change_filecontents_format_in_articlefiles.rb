class ChangeFilecontentsFormatInArticlefiles < ActiveRecord::Migration
  def up
    change_column :articlefiles, :filecontents, :LONGBLOB
  end
  
  def down
    change_column :articlefiles, :filecontents, :BLOB
  end
end
