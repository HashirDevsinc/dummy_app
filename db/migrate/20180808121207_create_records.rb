class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :comment_id
      t.integer :reporter_id

      t.timestamps
    end
    add_index :records, :comment_id
	add_index :records, :reporter_id
	add_index :records, [:comment_id, :reporter_id], unique: true
  end
end
