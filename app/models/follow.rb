class Follow < ApplicationRecord

  #user being followed
  belongs_to :following, foreign_key: :following_id, class_name: "User"
  #user is a follower
  belongs_to :follower, foreign_key: :follower_id, class_name: "User"
  
 
end
