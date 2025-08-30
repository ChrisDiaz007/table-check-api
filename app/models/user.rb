class User < ApplicationRecord
  enum role: { customer: 0, owner: 1 }

  # Restaurants
  has_many :restaurants, dependent: :destroy

  # Reservations
  has_many :reservations, dependent: :destroy

  # Followed restaurants
  has_many :follows, dependent: :destroy
  has_many :followed_restaurants, through: :follows, source: :restaurant

  # Favorite restaurants
  has_many :favorites, dependent: :destroy
  has_many :favorite_restaurants, through: :favorites, source: :restaurant

  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, presence: true
  validates :last_name, presence: true
end
