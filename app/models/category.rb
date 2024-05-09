class Category < ApplicationRecord
    validates :title, presence: true
    has_many :articles, dependent: :destroy
    def self.ransackable_associations(auth_object = nil)
        ["articles"]
    end
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "title", "updated_at"]
    end
end
