class Client < ApplicationRecord
    extend FriendlyId
    friendly_id :sub_domain, use: :slugged

    def to_param
        slug
    end

    validates :name, presence: true, uniqueness: true
    validates :sub_domain, presence: true, uniqueness: true
    # actual logo
    has_one_attached :background_image
    has_many :client_users, dependent: :destroy
    has_many :articles, dependent: :destroy

end



