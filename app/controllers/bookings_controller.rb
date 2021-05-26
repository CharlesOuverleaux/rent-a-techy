class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user:current_user)
  end

  def create
    @booking = Booking.new(set_booking_params)
    offer = Offer.find(params[:offer_id])
    @booking.offer = offer
    @booking.user = current_user
    @booking.status = "pending"
    if @booking.save
      redirect_to bookings_path
    else
      redirect_to offer_path(offer)
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end
  private
  def set_booking_params
    params.require(:booking).permit(:booking_date)
  end

end
