class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :role 
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.admin?
    where(role_id: Role.find_by(title: 'Admin').id).exists?
  end

  def self.clientadmin?
    where(role_id: Role.find_by(title: 'ClientAdmin').id).exists?
  end

  def self.author?
    where(role_id: Role.find_by(title: 'Author').id).exists?
  end

  def self.reader?
    where(role_id: Role.find_by(title: 'Reader').id).exists?
  end
end
