class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :microposts, dependent: :destroy
    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
    has_many :followers, through: :reverses_of_relationship, source: :user
    has_many :favorites
    has_many :like, through: :favorites, source: :micropost
    has_many :join_communities, dependent: :destroy
    has_many :join, through: :join_communities, source: :community
    has_many :join_communities, dependent: :destroy
    has_many :chat, through: :join_communities, source: :micropost
    
    def follow(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
      end
    end

    def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
    end

    def following?(other_user)
      self.followings.include?(other_user)
    end
    
    def favorite(other_micropost)
      self.favorites.find_or_create_by(micropost_id: other_micropost.id)
    end

    def unfavorite(other_micropost)
      favorite = self.favorites.find_by(micropost_id: other_micropost.id)
      favorite.destroy if favorite
    end

    def favorite?(other_micropost)
      self.like.include?(other_micropost)
    end
    
    def join_community(other_community)
      self.join_communities.find_or_create_by(community_id: other_community.id)
    end

    def unjoin_community(other_community)
      join_community = self.join_communities.find_by(community_id: other_community.id)
      join_community.destroy if join_community
    end

    def join_community?(other_community)
      self.join.include?(other_community)
    end
    
    def feed_microposts
    Micropost.where(user_id: self.join_ids + [self.id]).or(Micropost.where(community: id))
    end
    
    def chat(other_micropost)
      self.join_communities.find_or_create_by(micropost_id: other_micropost.id)
    end 
end
