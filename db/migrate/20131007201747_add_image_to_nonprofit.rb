class AddImageToNonprofit < ActiveRecord::Migration
  def change
    add_column :nonprofits, :image, :string
  end
end
