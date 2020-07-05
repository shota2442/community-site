class Community < ApplicationRecord
    
  validates :name, presence: true, length: { maximum: 15 }
  
  has_many :microposts
  has_many :join_communities
  has_many :join, through: :reverses_of_join_community, source: :user
end
