class AddStuffToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null:false
    add_column :users, :last_name, :string, null:false
    add_column :users, :city, :string, null:false
    add_column :users, :state, :string, null:false
    add_column :users, :zipcode, :string, null:false
    add_column :users, :about_me, :text
    add_column :users, :current_company, :string
  end
end
