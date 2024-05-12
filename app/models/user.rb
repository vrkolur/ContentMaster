class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :role 
  validates :name, presence: true
  validates :password, format: {with: /.{8,}/, message: " should have minimun 8 characters"}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "must be of valid format"}, uniqueness: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
