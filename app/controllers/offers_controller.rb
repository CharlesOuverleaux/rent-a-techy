class OffersController < ApplicationController
  before_action :set_offer, only: [:show]

  def index
    if params[:query].present?
      sql_query = " \
        offers.title @@ :query \
        OR offers.description @@ :query \
        OR users.first_name @@ :query \
        OR users.last_name @@ :query \
      "
      @offers = Offer.joins(:user).where(sql_query, query: "%#{params[:query]}%")

    else
      @offers = Offer.all
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @booking = Booking.new
  end

private

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
