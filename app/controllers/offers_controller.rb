class OffersController < ApplicationController
  before_action :set_offer, only: [:show]

  def index
    @skills = Skill.all.select { |skill| skill.offers.size > 0 }
    @selected_skills = params[:skills]
    @search = params[:query]
    @available = params[:availablenow] == 'on'
    @offers = Offer.all
    search_offers_by_search_query(@search) if @search.present?
    filter_offers_by_skills(@offers, @selected_skills) if @selected_skills.present?
    filter_by_availablity(@offers) if @available
    @offers
  end

  def show
    @offer = Offer.find(params[:id])
    @booking = Booking.new
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def search_offers_by_search_query(query)
    PgSearch::Multisearch.rebuild(Offer)
    PgSearch::Multisearch.rebuild(User)
    @search_query = PgSearch.multisearch(query)
    # MAKE THE SEARCH FOR THE USER
    @users_results = @search_query.map do |result|
      result.searchable_id if result.searchable_type == 'User'
    end
    # MAKE THE SEARCH FOR THE OFFER
    @offer_results = @search_query.map do |result|
      result.searchable_id if result.searchable_type == 'Offer'
    end
  end

  def filter_offers_by_skills(offers, selected_skills)
    @offers = offers.reject do |offer|
      available_skills = offer.skills.select do |skill|
        selected_skills.include? skill.name
      end
      available_skills.empty?
    end
  end

  def filter_by_availablity(offers)
    @offers = offers.select { |offer| offer.available_now }
  end
end
