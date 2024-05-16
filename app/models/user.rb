class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :role 
  validates :name, presence: true
  # validates :password, format: {
  #   with: /\A(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$%*?&])[A-Za-z\d@$%*?&]{8,}\z/,
  #   message: "must be a strong password"
  # }
  validates :email, presence: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
