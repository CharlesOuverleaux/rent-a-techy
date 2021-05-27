class OffersController < ApplicationController
  before_action :set_offer, only: [:show]

  def index
    if params[:query].present?
      @offers = Offer.search_by_title_and_description(params[:query])
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
