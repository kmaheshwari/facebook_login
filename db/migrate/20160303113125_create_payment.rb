class CreatePayment < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.string :email
    	t.string :pay_type
    end
  end
end
