class CreateChannelUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_users do |t|
      t.references :channel, foreign_key: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
