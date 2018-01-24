class AddIndexToComments < ActiveRecord::Migration[5.1]
  def change
  end
  add_index :comments, [:micropost_id, :created_at]
end
