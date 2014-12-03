class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :city
      t.string :country
      t.string :college
      t.datetime :dateOfBirth
      t.string :dateOfBirthRange
      t.string :educationDegree
      t.string :domainOfStudy
      t.string :occupation
      t.text :introduction

      t.timestamps
    end
  end
end
