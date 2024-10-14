class Item < ApplicationRecord
    has_one_attached :image
    belongs_to :user
  
    validates :category, presence: true
  
    # Method to check if the item is reserved by a specific user
    def reserved_by?(user)
      reserved_by == user.id
    end
  end