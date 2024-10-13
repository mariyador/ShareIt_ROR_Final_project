class Item < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    validates :category, presence: true
end
