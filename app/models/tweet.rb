class Tweet < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy

  validates :content, presence: true

  accepts_nested_attributes_for :likes, allow_destroy: true
  accepts_nested_attributes_for :retweets, allow_destroy: true
end
