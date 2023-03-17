class Room < ApplicationRecord
  has_one_attached :room_image
  belongs_to :user
  has_many :reservation, dependent: :destroy
  
  validates :room_name, presence: true
  validates :room_introduction, presence: true, length: { maximum: 300 }
  validates :price, presence: true, numericality: true
  validates :address, presence: true

  # 施設名、施設詳細を対象としたあいまい検索の実装
  def self.search(search)
    Room.where("room_name LIKE(?) or room_introduction LIKE(?)", "%#{search}%", "%#{search}%")
  end

  def self.area_search(search)
    Room.where("address LIKE(?)", "%#{search}%" )
  end
end
