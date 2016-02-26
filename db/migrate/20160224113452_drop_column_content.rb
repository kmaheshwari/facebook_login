class DropColumnContent < ActiveRecord::Migration
  def change
  	remove_column :posts, :content
  end
end
