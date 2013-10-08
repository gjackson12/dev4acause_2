class AddVisionToNonprofit < ActiveRecord::Migration
  def change
    add_column :nonprofits, :vision, :text
    add_column :nonprofits, :mission, :text
  end
end
