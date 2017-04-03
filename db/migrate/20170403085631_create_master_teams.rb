class CreateMasterTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :master_teams do |t|
      t.references :master, foreign_key: true, null: false
      t.references :team, foreign_key: true
      t.timestamps
    end
  end
end
