class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :subtitle
      t.string :subject
      t.string :description
      t.string :language
      t.string :format
      t.string :region
      t.string :isbn
      t.binary :articlefile
      t.string :articlefilename
      t.string :articlecontent
      t.date   :datepublished
      t.integer :user_id

      t.timestamps
    end
    add_index :articles, [:user_id, :created_at]
  end
end
