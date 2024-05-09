class Tag < ApplicationRecord
    validates :name, uniqueness: true
    has_many :article_tags
    has_many :articles, through: :article_tag

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "name", "updated_at"]
    end
end
