class User < ApplicationRecord
  
  acts_as_token_authenticatable
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
       
  validates :name, presence: true
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower, dependent: :destroy

  has_many :following_relationships, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :following_relationships, source: :following, dependent: :destroy

 
  
  
end
