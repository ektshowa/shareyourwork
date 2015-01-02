class Profile < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true, uniqueness: true
  validates :country, :dateOfBirthRange, :occupation, :introduction, presence: true

end
