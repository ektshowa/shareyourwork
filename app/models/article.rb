class Article < ActiveRecord::Base
  belongs_to :user
  has_many :articlefiles
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :title, :subject, :description, presence: true
  validate :required_articleFile_or_articleContent
     
  def required_articleFile_or_articleContent
    if !:articlefile.present? && !:articlecontent.present?
      errors.add(:articlefile, "You should upload an article or copy/paste the text")
    end
  end
  
  def self.getAllUserArticles(id)
    articles = Articles.where("user_id = ?", id)
  end
    
end
