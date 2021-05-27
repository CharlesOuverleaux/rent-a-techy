class Skill < ApplicationRecord
  has_and_belongs_to_many :offers, join_table: "offers_skills"
  validates :name, :color_code, presence: true
end
