class CreateNonprofits < ActiveRecord::Migration
  def change
    create_table :nonprofits do |t|
      t.string :name, null:false
      t.string :ein_num, null:false
      t.string :date_founded
      t.string :phone_number
      t.string :fax_number
      t.string :street_address
      t.string :street_address_2
      t.string :state, null:false
      t.string :city, null:false
      t.string :zipcode
      t.string :email_address
      t.string :website_string
      t.text :description_mission, null:false
      t.string :cause, null:false

      t.timestamps
    end
  end
end
