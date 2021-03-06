class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews
  has_and_belongs_to_many :skills, join_table: "offers_skills"

  validates :title, :description, presence: true
  validates :description, length: { minimum: 5, maximum: 250 }

  include PgSearch::Model
  multisearchable against: [:title, :description]
end
