class AddRoomImageToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :room_image, :string
  end
end
