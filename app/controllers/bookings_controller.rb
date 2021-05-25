class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new
    @booking.status = "pending"
    if @booking.save
      redirect_to offers_index_path
    end
  end
end
