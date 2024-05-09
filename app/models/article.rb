class Article < ApplicationRecord

  #validations
  validates :title, presence: true
  validates :body, presence: true

  # association 
  belongs_to :client
  belongs_to :category
  belongs_to :client_user

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  

  # attachment for images
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["category_id",  "heading", "title"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["article_tags", "category", "tags"]
  end


end
