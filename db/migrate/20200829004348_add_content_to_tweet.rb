class AddContentToTweet < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :content, :string,   null: false, default: ""
  end
end
