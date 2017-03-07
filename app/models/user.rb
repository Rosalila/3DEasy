class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_in_printing_hubs
  has_many :printing_hubs, through: :user_in_printing_hubs
  has_many :orders
  has_many :cart_items
end
