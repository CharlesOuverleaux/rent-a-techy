class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :offers
  ROLES = ["user", "techy"]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, :user_name, :role, presence: true
  validates_format_of :first_name, :last_name, :with => /\A [A-Z]|[-a-z]+\Z/
  validates :email, uniqueness: true
  validates :role, inclusion: { in: ROLES }
  validates :user_name, length: { minimum: 5, maximum: 20 }
end
