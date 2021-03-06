class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles

  validates :name, uniqueness: true
end
