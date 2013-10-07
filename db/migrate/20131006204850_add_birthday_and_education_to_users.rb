class AddBirthdayAndEducationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :education, :string
    add_column :users, :reason_here, :text
  end
end
