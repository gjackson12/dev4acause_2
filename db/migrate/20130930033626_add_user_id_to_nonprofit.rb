class AddUserIdToNonprofit < ActiveRecord::Migration
  def change
    add_column :nonprofits, :user_id, :integer
  end
end
