class AddDefaultValueToLikesCount < ActiveRecord::Migration[6.0]
  def up
    change_column :tweets, :likes_count, :integer, :default => 0
  end

  def down
    change_column :tweets, :likes_count, :integer, :default => nil
  end
end
