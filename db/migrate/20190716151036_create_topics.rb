class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :name
      t.datetime :last_post_at

      t.timestamps
    end
  end
end
