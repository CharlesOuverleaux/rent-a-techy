class Offer < ApplicationRecord
  belongs_to :user

  validates :title, :description, presence: true
  validates :description, length: { minimum: 5, maximum: 250 }
end
