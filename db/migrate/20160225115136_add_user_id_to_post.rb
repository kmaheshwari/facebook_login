class AddUserIdToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :user_id, :integer, :default => nil

  end
end
