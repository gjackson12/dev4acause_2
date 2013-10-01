class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.text :description, null:false
      t.text :current_stack, null:false
      t.string :street_address
      t.string :city
      t.string :state
      t.text :extra_details
      t.string :duration
      t.string :time_commitment
      t.date :start_date
      t.date :end_date
      t.string :headline, null:false
      t.string :zipcode
      t.integer :nonprofit_id, null:false
      t.text :application_info, null:false

      t.timestamps
    end
  end
end
