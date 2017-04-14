class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.string :image
      t.references :master
      t.references :team
      t.references :user
      t.references :channel
      t.timestamps
    end
  end
end
