class Booking < ApplicationRecord
  belongs_to :offer
  belongs_to :user

  STATUS = ["pending", "confirmed", "declined"]
  validates :status, inclusion: { in: STATUS }
  # validates :booking_date, presence: true
end
