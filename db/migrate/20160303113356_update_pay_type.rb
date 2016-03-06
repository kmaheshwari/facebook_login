class UpdatePayType < ActiveRecord::Migration
  def change
  	change_column :payments, :pay_type, :string, :default => nil
  end
end
