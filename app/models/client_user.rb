class ClientUser < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :articles
end
