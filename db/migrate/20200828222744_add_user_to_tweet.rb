class AddUserToTweet < ActiveRecord::Migration[6.0]
  def change
    add_reference :tweets, :users, :integer, null: false, foreign_key: true
  end
end
