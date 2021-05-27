class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_and_belongs_to_many :skills, join_table: "offers_skills"

  validates :title, :description, presence: true
  validates :description, length: { minimum: 5, maximum: 250 }


  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
    against: [ :title, :description],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
