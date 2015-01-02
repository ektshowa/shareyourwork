class CreateCommentmicroposts < ActiveRecord::Migration
  def change
    create_table :commentmicroposts do |t|
      t.string :content
      t.integer :user_id
      
      t.references :micropost
      
      t.timestamps
    end
  end
end
