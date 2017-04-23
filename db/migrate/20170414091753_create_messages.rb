class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.string :image
      t.string :user_name
      t.references :master
      t.references :team
      t.references :user
      t.references :channel
      t.references :direct
      t.timestamps
    end
  end
end
