class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :community
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :like, through: :reverses_of_favorite, source: :user
  has_many :join_communities, dependent: :destroy
  has_many :chat, through: :reverses_of_join_community, source: :community
end