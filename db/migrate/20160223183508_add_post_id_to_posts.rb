class AddPostIdToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :post_id, :number, :default => nil
  end
end
