class AddCreaterToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :creator, :integer
  end
end
