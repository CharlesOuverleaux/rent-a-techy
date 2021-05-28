class Booking < ApplicationRecord
  belongs_to :offer
  belongs_to :user
  has_many :notifications, dependent: :destroy

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
      fn = booking.offer.user.first_name
      msg = "#{fn} confirmed your booking! Get ready :)" if i == 1
      msg = "#{fn} declined your booking! Next time :(" if i == 2
      Notification.create(booking: booking, user: booking.user, msg: msg)
    end
  end
end
