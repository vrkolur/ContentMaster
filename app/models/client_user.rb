class ClientUser < ApplicationRecord
  belongs_to :client
  belongs_to :user, dependent: :destroy
  has_many :articles, dependent: :destroy
end
