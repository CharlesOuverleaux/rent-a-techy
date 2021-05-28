class Booking < ApplicationRecord
  belongs_to :offer
  belongs_to :user

  STATUS = ["pending", "confirmed", "declined"]
  validates :status, inclusion: { in: STATUS }
  validates :booking_date, presence: true

  after_commit :change_status_fake, on: [:create]

  # adjust booking status after time
  def change_status_fake
    Thread.new do
      sleep(5)
      booking = Booking.find(id)
      i = rand(1..2)
      booking.status = STATUS[i]
      booking.save

      # create notification
      msg = 'Your booking was confirmed!' if i == 1
      msg = 'Your booking was declined!' if i == 2
      Notification.create(booking: booking, user: booking.user, msg: msg)
    end
  end
end
