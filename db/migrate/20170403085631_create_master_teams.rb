class CreateMasterTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :master_teams do |t|
      t.references :master, null: false
      t.references :team
      t.timestamps
    end
  end
end
