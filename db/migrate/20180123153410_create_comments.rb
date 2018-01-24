class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.integer :micropost_id

      t.timestamps
    end
    add_index :comments, :micropost_id
    add_index :comments, :user_id
  end
end
