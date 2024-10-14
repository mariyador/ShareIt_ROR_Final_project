class Item < ApplicationRecord
    has_one_attached :image
    belongs_to :user

    validates :category, presence: true

    # Method to check if the item is reserved by a specific user
    def reserved_by?(user)
        return false if reserved_by.nil?
        reserved_by == user.id
      end
end
