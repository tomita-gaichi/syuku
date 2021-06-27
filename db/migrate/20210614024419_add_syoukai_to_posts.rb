class AddSyoukaiToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :syoukai, :text
  end
end
