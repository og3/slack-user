class CreateDirects < ActiveRecord::Migration[5.0]
  def change
    create_table :directs do |t|
      t.string :name, null: false
      t.string :team_id, null: false
      t.timestamps
    end
  end
end
