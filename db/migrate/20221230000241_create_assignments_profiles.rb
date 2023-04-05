class CreateAssignmentsProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments_profiles do |t|
      t.references :assignated, polymorphic: true
      t.references :profile, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :active, default:true

      t.timestamps
    end
  end
end
