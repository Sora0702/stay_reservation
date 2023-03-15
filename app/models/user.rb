class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, length: { maximum: 300 }

  has_many :rooms, foreign_key: 'user_id'
  has_many :reservation
end
