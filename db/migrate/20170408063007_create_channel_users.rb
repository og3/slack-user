class CreateChannelUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_users do |t|
      t.references :channel
      t.references :user
      t.timestamps
    end
  end
end
