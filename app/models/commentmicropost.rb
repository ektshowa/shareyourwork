class Commentmicropost < ActiveRecord::Base
  
  belongs_to :micropost
  belongs_to :article
  
  validates :content, presence: true
end