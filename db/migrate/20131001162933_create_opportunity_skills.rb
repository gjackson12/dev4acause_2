class CreateOpportunitySkills < ActiveRecord::Migration
  def change
    create_table :opportunity_skills do |t|
      t.integer :skill_id, null:false
      t.integer :opportunity_id, null:false

      t.timestamps
    end
  end
end
