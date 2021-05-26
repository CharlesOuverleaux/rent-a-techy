class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new(offer_id: params[:offer_id], user:current_user)
    @booking.status = "pending"
    if @booking.save
      redirect_to offers_path
    end
  end
end
