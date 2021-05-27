class OffersController < ApplicationController
  before_action :set_offer, only: [:show]

  def index
    @search = params[:query]
    if @search.present?
      @offers = Offer.all
      PgSearch::Multisearch.rebuild(Offer)
      PgSearch::Multisearch.rebuild(User)
      @search_query = PgSearch.multisearch(params[:query])
      # MAKE THE SEARCH FOR THE USER
      @users_results = @search_query.map do |result|
        if result.searchable_type == 'User'
          result.searchable_id
        end
      end
      # MAKE THE SEARCH FOR THE OFFER
      @offer_results = @search_query.map do |result|
        if result.searchable_type == 'Offer'
          result.searchable_id
        end
      end
      @users = User.where(id: @users_results)
    end
    @offers = Offer.all
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
