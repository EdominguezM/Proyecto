class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy

  validates :content, presence: true

  accepts_nested_attributes_for :likes, allow_destroy: true
  accepts_nested_attributes_for :retweets, allow_destroy: true

 
  scope :last_tweets, -> { order("created_at DESC")}

  scope :dates_tweets, -> (from, to) {where("created_at >= ? and created_at <= ?", from, to) }

  def image_avatar
    user.image_url
  end

  scope :tweets_for_me, -> (following_users) { where user_id: following_users}

  scope :tweets_of_me, -> (follower_users) { where user_id: follower_users}
  
end
