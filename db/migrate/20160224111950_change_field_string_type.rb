class ChangeFieldStringType < ActiveRecord::Migration
  def change
  	change_column :posts, :post_id, :string
  end
end
