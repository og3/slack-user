class CreateDirectUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :direct_users do |t|
      t.references :direct
      t.references :user
      t.timestamps
    end
  end
end
