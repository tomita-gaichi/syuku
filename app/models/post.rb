class Post < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy 

  with_options presence: true do
   validates :name
   validates :syoukai
   validates :price, :numericality => {:less_than => 2147483647}
   validates :address
   validates :image
  end

  mount_uploader :image, ImageUploader
end
