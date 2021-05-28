class Booking < ApplicationRecord
  belongs_to :offer
  belongs_to :user

  STATUS = ["pending", "confirmed", "declined"]
  validates :status, inclusion: { in: STATUS }
  validates :booking_date, presence: true

  after_commit :change_status_fake, on: [:create]

  def change_status_fake
    Thread.new do
      sleep(5)
      booking = Booking.find(id)
      booking.status = STATUS[rand(1..2)]
      booking.save
    end
  end
end
